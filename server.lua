-- ServerScriptService: RoogleServer
local DataStoreService = game:GetService("DataStoreService")
local ArticlesStore = DataStoreService:GetDataStore("RoogleArticles")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Crear RemoteEvents y RemoteFunctions
local RemoteFolder = Instance.new("Folder")
RemoteFolder.Name = "RoogleRemotes"
RemoteFolder.Parent = ReplicatedStorage

local SearchArticles = Instance.new("RemoteFunction")
SearchArticles.Name = "SearchArticles"
SearchArticles.Parent = RemoteFolder

local GetAllArticles = Instance.new("RemoteFunction")
GetAllArticles.Name = "GetAllArticles"
GetAllArticles.Parent = RemoteFolder

local PublishArticle = Instance.new("RemoteEvent")
PublishArticle.Name = "PublishArticle"
PublishArticle.Parent = RemoteFolder

local DeleteArticle = Instance.new("RemoteEvent")
DeleteArticle.Name = "DeleteArticle"
DeleteArticle.Parent = RemoteFolder

-- Lista de administradores (agrega los nombres de usuario aquí)
local ADMINS = {
	"Vegetl_t", -- Agrega más nombres aquí
	-- "OtroAdmin",
}

-- Función para verificar si un jugador es admin
local function isAdmin(player)
	for _, adminName in ipairs(ADMINS) do
		if player.Name == adminName then
			return true
		end
	end
	return false
end

-- Función para generar ID único
local function generateId()
	return tostring(os.time()) .. "_" .. tostring(math.random(1000, 9999))
end

-- Función para buscar artículos
SearchArticles.OnServerInvoke = function(player, searchTerm)
	local success, allArticlesData = pcall(function()
		return ArticlesStore:GetAsync("AllArticles") or {}
	end)

	if not success then
		return {}
	end

	if searchTerm == "" or searchTerm == nil then
		return allArticlesData
	end

	local results = {}
	searchTerm = string.lower(searchTerm)

	for _, article in pairs(allArticlesData) do
		local titleMatch = string.find(string.lower(article.Title), searchTerm, 1, true)
		local contentMatch = string.find(string.lower(article.Content), searchTerm, 1, true)

		if titleMatch or contentMatch then
			table.insert(results, article)
		end
	end

	return results
end

-- Función para obtener todos los artículos
GetAllArticles.OnServerInvoke = function(player)
	local success, allArticlesData = pcall(function()
		return ArticlesStore:GetAsync("AllArticles") or {}
	end)

	if success then
		return allArticlesData
	else
		return {}
	end

end

-- Evento para publicar artículos (solo admins)
PublishArticle.OnServerEvent:Connect(function(player, articleData)
	if not isAdmin(player) then
		warn(player.Name .. " intentó publicar un artículo sin ser admin")
		return
	end

	local success, err = pcall(function()
		local allArticles = ArticlesStore:GetAsync("AllArticles") or {}

		local newArticle = {
			Id = generateId(),
			Title = articleData.Title,
			Content = articleData.Content,
			Author = player.Name,
			AuthorImage = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150",
			Date = articleData.Date or os.date("%d/%m/%Y"),
			Timestamp = os.time()
		}

		table.insert(allArticles, newArticle)
		ArticlesStore:SetAsync("AllArticles", allArticles)

		print("Artículo publicado por " .. player.Name .. ": " .. newArticle.Title)
	end)

	if not success then
		warn("Error al publicar artículo: " .. tostring(err))
	end
end)

-- Evento para eliminar artículos (solo admins)
DeleteArticle.OnServerEvent:Connect(function(player, articleId)
	if not isAdmin(player) then
		warn(player.Name .. " intentó eliminar un artículo sin ser admin")
		return
	end

	local success, err = pcall(function()
		local allArticles = ArticlesStore:GetAsync("AllArticles") or {}

		for i, article in ipairs(allArticles) do
			if article.Id == articleId then
				table.remove(allArticles, i)
				break
			end
		end

		ArticlesStore:SetAsync("AllArticles", allArticles)
		print("Artículo eliminado por " .. player.Name)
	end)

	if not success then
		warn("Error al eliminar artículo: " .. tostring(err))
	end
end)

-- Enviar estado de admin al jugador cuando entra
game.Players.PlayerAdded:Connect(function(player)
	local isAdminValue = Instance.new("BoolValue")
	isAdminValue.Name = "IsAdmin"
	isAdminValue.Value = isAdmin(player)
	isAdminValue.Parent = player

	print(player.Name .. " se unió. Admin: " .. tostring(isAdminValue.Value))
end)

