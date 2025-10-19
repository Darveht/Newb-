-- StarterPlayer > StarterPlayerScripts: RoogleClient
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Esperar a que los remotes estén listos
local RemoteFolder = ReplicatedStorage:WaitForChild("RoogleRemotes")
local SearchArticles = RemoteFolder:WaitForChild("SearchArticles")
local GetAllArticles = RemoteFolder:WaitForChild("GetAllArticles")
local PublishArticle = RemoteFolder:WaitForChild("PublishArticle")
local DeleteArticle = RemoteFolder:WaitForChild("DeleteArticle") -- Added missing DeleteArticle reference

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RoogleGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- PANTALLA PRINCIPAL
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.Position = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Header con logo Roogle
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 80)
header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
header.BorderSizePixel = 0
header.Parent = mainFrame

local logo = Instance.new("TextLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(0, 200, 0, 50)
logo.Position = UDim2.new(0, 30, 0, 15)
logo.BackgroundTransparency = 1
logo.Text = "Roogle"
logo.Font = Enum.Font.GothamBold
logo.TextSize = 42
logo.TextColor3 = Color3.fromRGB(66, 133, 244)
logo.TextXAlignment = Enum.TextXAlignment.Left
logo.Parent = header

-- Barra de búsqueda
local searchContainer = Instance.new("Frame")
searchContainer.Name = "SearchContainer"
searchContainer.Size = UDim2.new(0, 600, 0, 45)
searchContainer.Position = UDim2.new(0.5, -300, 0, 100)
searchContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
searchContainer.BorderSizePixel = 1
searchContainer.BorderColor3 = Color3.fromRGB(223, 225, 229)
searchContainer.Parent = mainFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 24)
searchCorner.Parent = searchContainer

local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBox"
searchBox.Size = UDim2.new(1, -100, 1, 0)
searchBox.Position = UDim2.new(0, 20, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.Text = ""
searchBox.PlaceholderText = "Buscar en Roogle..."
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 16
searchBox.TextColor3 = Color3.fromRGB(32, 33, 36)
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false
searchBox.Parent = searchContainer

local searchButton = Instance.new("TextButton")
searchButton.Name = "SearchButton"
searchButton.Size = UDim2.new(0, 80, 0, 35)
searchButton.Position = UDim2.new(1, -85, 0.5, -17.5)
searchButton.BackgroundColor3 = Color3.fromRGB(66, 133, 244)
searchButton.Text = "Buscar"
searchButton.Font = Enum.Font.GothamMedium
searchButton.TextSize = 14
searchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
searchButton.Parent = searchContainer

local searchBtnCorner = Instance.new("UICorner")
searchBtnCorner.CornerRadius = UDim.new(0, 18)
searchBtnCorner.Parent = searchButton

-- Contenedor de resultados con scroll
local resultsContainer = Instance.new("ScrollingFrame")
resultsContainer.Name = "ResultsContainer"
resultsContainer.Size = UDim2.new(0, 800, 1, -180)
resultsContainer.Position = UDim2.new(0.5, -400, 0, 170)
resultsContainer.BackgroundTransparency = 1
resultsContainer.BorderSizePixel = 0
resultsContainer.ScrollBarThickness = 8
resultsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
resultsContainer.Parent = mainFrame

local resultsLayout = Instance.new("UIListLayout")
resultsLayout.SortOrder = Enum.SortOrder.LayoutOrder
resultsLayout.Padding = UDim.new(0, 15)
resultsLayout.Parent = resultsContainer

-- PANTALLA DE ARTÍCULO COMPLETO
local articleFrame = Instance.new("Frame")
articleFrame.Name = "ArticleFrame"
articleFrame.Size = UDim2.new(1, 0, 1, 0)
articleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
articleFrame.Visible = false
articleFrame.Parent = screenGui

local articleScroll = Instance.new("ScrollingFrame")
articleScroll.Size = UDim2.new(0, 900, 1, -100)
articleScroll.Position = UDim2.new(0.5, -450, 0, 80)
articleScroll.BackgroundTransparency = 1
articleScroll.BorderSizePixel = 0
articleScroll.ScrollBarThickness = 8
articleScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
articleScroll.Parent = articleFrame

local backButton = Instance.new("TextButton")
backButton.Name = "BackButton"
backButton.Size = UDim2.new(0, 120, 0, 40)
backButton.Position = UDim2.new(0, 30, 0, 20)
backButton.BackgroundColor3 = Color3.fromRGB(66, 133, 244)
backButton.Text = "← Volver"
backButton.Font = Enum.Font.GothamMedium
backButton.TextSize = 16
backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
backButton.Parent = articleFrame

local backCorner = Instance.new("UICorner")
backCorner.CornerRadius = UDim.new(0, 8)
backCorner.Parent = backButton

-- PANEL DE ADMINISTRADOR
local adminPanel = Instance.new("Frame")
adminPanel.Name = "AdminPanel"
adminPanel.Size = UDim2.new(0, 400, 0, 500)
adminPanel.Position = UDim2.new(1, -420, 0, 100)
adminPanel.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
adminPanel.BorderSizePixel = 1
adminPanel.BorderColor3 = Color3.fromRGB(200, 200, 200)
adminPanel.Visible = false
adminPanel.Parent = mainFrame

local adminCorner = Instance.new("UICorner")
adminCorner.CornerRadius = UDim.new(0, 10)
adminCorner.Parent = adminPanel

local adminTitle = Instance.new("TextLabel")
adminTitle.Size = UDim2.new(1, 0, 0, 40)
adminTitle.BackgroundColor3 = Color3.fromRGB(66, 133, 244)
adminTitle.Text = "Panel de Administrador"
adminTitle.Font = Enum.Font.GothamBold
adminTitle.TextSize = 18
adminTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
adminTitle.Parent = adminPanel

local adminTitleCorner = Instance.new("UICorner")
adminTitleCorner.CornerRadius = UDim.new(0, 10)
adminTitleCorner.Parent = adminTitle

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 20)
titleLabel.Position = UDim2.new(0, 10, 0, 60)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Título del artículo:"
titleLabel.Font = Enum.Font.GothamMedium
titleLabel.TextSize = 14
titleLabel.TextColor3 = Color3.fromRGB(50, 50, 50)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = adminPanel

local titleInput = Instance.new("TextBox")
titleInput.Size = UDim2.new(1, -20, 0, 35)
titleInput.Position = UDim2.new(0, 10, 0, 85)
titleInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titleInput.BorderSizePixel = 1
titleInput.BorderColor3 = Color3.fromRGB(200, 200, 200)
titleInput.Text = ""
titleInput.PlaceholderText = "Ej: Historia de Cuba"
titleInput.Font = Enum.Font.Gotham
titleInput.TextSize = 14
titleInput.TextColor3 = Color3.fromRGB(32, 33, 36)
titleInput.TextXAlignment = Enum.TextXAlignment.Left
titleInput.ClearTextOnFocus = false
titleInput.Parent = adminPanel

local contentLabel = Instance.new("TextLabel")
contentLabel.Size = UDim2.new(1, -20, 0, 20)
contentLabel.Position = UDim2.new(0, 10, 0, 135)
contentLabel.BackgroundTransparency = 1
contentLabel.Text = "Contenido del artículo:"
contentLabel.Font = Enum.Font.GothamMedium
contentLabel.TextSize = 14
contentLabel.TextColor3 = Color3.fromRGB(50, 50, 50)
contentLabel.TextXAlignment = Enum.TextXAlignment.Left
contentLabel.Parent = adminPanel

local contentInput = Instance.new("TextBox")
contentInput.Size = UDim2.new(1, -20, 0, 180)
contentInput.Position = UDim2.new(0, 10, 0, 160)
contentInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
contentInput.BorderSizePixel = 1
contentInput.BorderColor3 = Color3.fromRGB(200, 200, 200)
contentInput.Text = ""
contentInput.PlaceholderText = "Escribe el contenido completo aquí..."
contentInput.Font = Enum.Font.Gotham
contentInput.TextSize = 13
contentInput.TextColor3 = Color3.fromRGB(32, 33, 36)
contentInput.TextXAlignment = Enum.TextXAlignment.Left
contentInput.TextYAlignment = Enum.TextYAlignment.Top
contentInput.MultiLine = true
contentInput.ClearTextOnFocus = false
contentInput.TextWrapped = true
contentInput.Parent = adminPanel

local dateLabel = Instance.new("TextLabel")
dateLabel.Size = UDim2.new(1, -20, 0, 20)
dateLabel.Position = UDim2.new(0, 10, 0, 355)
dateLabel.BackgroundTransparency = 1
dateLabel.Text = "Fecha (opcional):"
dateLabel.Font = Enum.Font.GothamMedium
dateLabel.TextSize = 14
dateLabel.TextColor3 = Color3.fromRGB(50, 50, 50)
dateLabel.TextXAlignment = Enum.TextXAlignment.Left
dateLabel.Parent = adminPanel

local dateInput = Instance.new("TextBox")
dateInput.Size = UDim2.new(1, -20, 0, 35)
dateInput.Position = UDim2.new(0, 10, 0, 380)
dateInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dateInput.BorderSizePixel = 1
dateInput.BorderColor3 = Color3.fromRGB(200, 200, 200)
dateInput.Text = ""
dateInput.PlaceholderText = "Ej: 19/10/2025 (déjalo vacío para fecha automática)"
dateInput.Font = Enum.Font.Gotham
dateInput.TextSize = 13
dateInput.TextColor3 = Color3.fromRGB(32, 33, 36)
dateInput.TextXAlignment = Enum.TextXAlignment.Left
dateInput.ClearTextOnFocus = false
dateInput.Parent = adminPanel

local publishButton = Instance.new("TextButton")
publishButton.Size = UDim2.new(1, -20, 0, 45)
publishButton.Position = UDim2.new(0, 10, 0, 435)
publishButton.BackgroundColor3 = Color3.fromRGB(52, 168, 83)
publishButton.Text = "📝 Publicar Artículo"
publishButton.Font = Enum.Font.GothamBold
publishButton.TextSize = 16
publishButton.TextColor3 = Color3.fromRGB(255, 255, 255)
publishButton.Parent = adminPanel

local publishCorner = Instance.new("UICorner")
publishCorner.CornerRadius = UDim.new(0, 8)
publishCorner.Parent = publishButton

-- Botón para mostrar/ocultar panel admin
local adminToggle = Instance.new("TextButton")
adminToggle.Size = UDim2.new(0, 50, 0, 50)
adminToggle.Position = UDim2.new(1, -70, 0, 15)
adminToggle.BackgroundColor3 = Color3.fromRGB(66, 133, 244)
adminToggle.Text = "⚙️"
adminToggle.Font = Enum.Font.GothamBold
adminToggle.TextSize = 24
adminToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
adminToggle.Visible = false
adminToggle.Parent = header

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 25)
toggleCorner.Parent = adminToggle

-- Funciones
local function createArticleCard(articleData)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 120)
	card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	card.BorderSizePixel = 1
	card.BorderColor3 = Color3.fromRGB(218, 220, 224)

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 8)
	cardCorner.Parent = card

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -20, 0, 30)
	title.Position = UDim2.new(0, 10, 0, 10)
	title.BackgroundTransparency = 1
	title.Text = articleData.Title
	title.Font = Enum.Font.GothamBold
	title.TextSize = 18
	title.TextColor3 = Color3.fromRGB(26, 13, 171)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextTruncate = Enum.TextTruncate.AtEnd
	title.Parent = card

	local preview = Instance.new("TextLabel")
	preview.Size = UDim2.new(1, -20, 0, 40)
	preview.Position = UDim2.new(0, 10, 0, 45)
	preview.BackgroundTransparency = 1
	preview.Text = string.sub(articleData.Content, 1, 150) .. "..."
	preview.Font = Enum.Font.Gotham
	preview.TextSize = 14
	preview.TextColor3 = Color3.fromRGB(95, 99, 104)
	preview.TextXAlignment = Enum.TextXAlignment.Left
	preview.TextYAlignment = Enum.TextYAlignment.Top
	preview.TextWrapped = true
	preview.Parent = card

	local author = Instance.new("TextLabel")
	author.Size = UDim2.new(0.5, -10, 0, 20)
	author.Position = UDim2.new(0, 10, 1, -30)
	author.BackgroundTransparency = 1
	author.Text = "Por " .. articleData.Author
	author.Font = Enum.Font.Gotham
	author.TextSize = 12
	author.TextColor3 = Color3.fromRGB(95, 99, 104)
	author.TextXAlignment = Enum.TextXAlignment.Left
	author.Parent = card

	local date = Instance.new("TextLabel")
	date.Size = UDim2.new(0.5, -10, 0, 20)
	date.Position = UDim2.new(0.5, 0, 1, -30)
	date.BackgroundTransparency = 1
	date.Text = articleData.Date
	date.Font = Enum.Font.Gotham
	date.TextSize = 12
	date.TextColor3 = Color3.fromRGB(95, 99, 104)
	date.TextXAlignment = Enum.TextXAlignment.Right
	date.Parent = card

	local openButton = Instance.new("TextButton")
	openButton.Size = UDim2.new(1, 0, 1, 0)
	openButton.BackgroundTransparency = 1
	openButton.Text = ""
	openButton.Parent = card

	openButton.MouseButton1Click:Connect(function()
		showArticle(articleData)
	end)

	return card
end

function showArticle(articleData)
	mainFrame.Visible = false
	articleFrame.Visible = true

	articleScroll:ClearAllChildren()

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 20)
	layout.Parent = articleScroll

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, 0, 0, 50)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = articleData.Title
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 32
	titleLabel.TextColor3 = Color3.fromRGB(32, 33, 36)
	titleLabel.TextWrapped = true
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.AutomaticSize = Enum.AutomaticSize.Y
	titleLabel.Parent = articleScroll

	local authorContainer = Instance.new("Frame")
	authorContainer.Size = UDim2.new(1, 0, 0, 60)
	authorContainer.BackgroundTransparency = 1
	authorContainer.Parent = articleScroll

	local authorImage = Instance.new("ImageLabel")
	authorImage.Size = UDim2.new(0, 50, 0, 50)
	authorImage.Position = UDim2.new(0, 0, 0, 5)
	authorImage.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	authorImage.Image = articleData.AuthorImage
	authorImage.Parent = authorContainer

	local imgCorner = Instance.new("UICorner")
	imgCorner.CornerRadius = UDim.new(1, 0)
	imgCorner.Parent = authorImage

	local authorInfo = Instance.new("TextLabel")
	authorInfo.Size = UDim2.new(1, -70, 0, 50)
	authorInfo.Position = UDim2.new(0, 65, 0, 5)
	authorInfo.BackgroundTransparency = 1
	authorInfo.Text = "Escrito por " .. articleData.Author .. "\n" .. articleData.Date
	authorInfo.Font = Enum.Font.Gotham
	authorInfo.TextSize = 14
	authorInfo.TextColor3 = Color3.fromRGB(95, 99, 104)
	authorInfo.TextXAlignment = Enum.TextXAlignment.Left
	authorInfo.TextYAlignment = Enum.TextYAlignment.Center
	authorInfo.Parent = authorContainer

	local divider = Instance.new("Frame")
	divider.Size = UDim2.new(1, 0, 0, 2)
	divider.BackgroundColor3 = Color3.fromRGB(218, 220, 224)
	divider.BorderSizePixel = 0
	divider.Parent = articleScroll

	local contentLabel = Instance.new("TextLabel")
	contentLabel.Size = UDim2.new(1, 0, 0, 100)
	contentLabel.BackgroundTransparency = 1
	contentLabel.Text = articleData.Content
	contentLabel.Font = Enum.Font.Gotham
	contentLabel.TextSize = 16
	contentLabel.TextColor3 = Color3.fromRGB(32, 33, 36)
	contentLabel.TextWrapped = true
	contentLabel.TextXAlignment = Enum.TextXAlignment.Left
	contentLabel.TextYAlignment = Enum.TextYAlignment.Top
	contentLabel.AutomaticSize = Enum.AutomaticSize.Y
	contentLabel.Parent = articleScroll

	task.wait()
	articleScroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 40)
end

local function searchArticlesFunc()
	local searchTerm = searchBox.Text
	resultsContainer:ClearAllChildren()

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 15)
	layout.Parent = resultsContainer

	local results = SearchArticles:InvokeServer(searchTerm)

	if #results == 0 then
		local noResults = Instance.new("TextLabel")
		noResults.Size = UDim2.new(1, 0, 0, 100)
		noResults.BackgroundTransparency = 1
		noResults.Text = "No se encontraron resultados"
		noResults.Font = Enum.Font.Gotham
		noResults.TextSize = 18
		noResults.TextColor3 = Color3.fromRGB(95, 99, 104)
		noResults.Parent = resultsContainer
	else
		for _, article in ipairs(results) do
			local card = createArticleCard(article)
			card.Parent = resultsContainer
		end
	end

	task.wait()
	resultsContainer.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)

end

-- Eventos
searchButton.MouseButton1Click:Connect(searchArticlesFunc)
searchBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		searchArticlesFunc()
	end
end)

backButton.MouseButton1Click:Connect(function()
	articleFrame.Visible = false
	mainFrame.Visible = true
end)

adminToggle.MouseButton1Click:Connect(function()
	adminPanel.Visible = not adminPanel.Visible
end)

publishButton.MouseButton1Click:Connect(function()
	if titleInput.Text ~= "" and contentInput.Text ~= "" then
		local articleData = {
			Title = titleInput.Text,
			Content = contentInput.Text,
			Date = dateInput.Text ~= "" and dateInput.Text or nil
		}

		PublishArticle:FireServer(articleData)

		titleInput.Text = ""
		contentInput.Text = ""
		dateInput.Text = ""

		adminPanel.Visible = false

		wait(0.5)
		searchArticlesFunc()
	end
end)

-- Verificar si el jugador es admin
player:WaitForChild("IsAdmin")
if player.IsAdmin.Value then
	adminToggle.Visible = true
end

-- Cargar artículos iniciales
wait(1)
searchArticlesFunc()

