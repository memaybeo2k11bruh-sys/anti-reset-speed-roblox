-- Xóa Menu cũ nếu có để tránh trùng lặp
local oldUI = game.CoreGui:FindFirstChild("PinSimpleMenu")
if oldUI then oldUI:Destroy() end

-- Biến toàn cục để quản lý vòng lặp ép tốc độ
getgenv().LoopSpeedEnabled = false
getgenv().TargetSpeed = 16

-- Khởi tạo Giao diện (GUI)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedInput = Instance.new("TextBox")
local ApplyBtn = Instance.new("TextButton")
local ResetBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Cấu hình Menu chính
ScreenGui.Name = "PinSimpleMenu"
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame

-- Tiêu đề Menu
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "anti reset speed by pin "
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- Ô nhập số tốc độ
SpeedInput.Name = "SpeedInput"
SpeedInput.Parent = MainFrame
SpeedInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpeedInput.Position = UDim2.new(0.1, 0, 0.25, 0)
SpeedInput.Size = UDim2.new(0.8, 0, 0, 35)
SpeedInput.Font = Enum.Font.SourceSans
SpeedInput.PlaceholderText = "speed number..."
SpeedInput.Text = ""
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.TextSize = 16

-- Nút Áp dụng
ApplyBtn.Name = "ApplyBtn"
ApplyBtn.Parent = MainFrame
ApplyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 70)
ApplyBtn.Position = UDim2.new(0.1, 0, 0.52, 0)
ApplyBtn.Size = UDim2.new(0.8, 0, 0, 30)
ApplyBtn.Font = Enum.Font.SourceSansBold
ApplyBtn.Text = "Apply+lock speed"
ApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyBtn.TextSize = 15

-- Nút Reset
ResetBtn.Name = "ResetBtn"
ResetBtn.Parent = MainFrame
ResetBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
ResetBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
ResetBtn.Size = UDim2.new(0.8, 0, 0, 30)
ResetBtn.Font = Enum.Font.SourceSansBold
ResetBtn.Text = "rest speed"
ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetBtn.TextSize = 14

-- Vòng lặp Heartbeat chạy ngầm để ép tốc độ liên tục chống map reset
game:GetService("RunService").Heartbeat:Connect(function()
    if getgenv().LoopSpeedEnabled then
        pcall(function()
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = getgenv().TargetSpeed
            end
        end)
    end
end)

-- Xử lý khi bấm nút Áp Dụng
ApplyBtn.MouseButton1Click:Connect(function()
    local speedValue = tonumber(SpeedInput.Text)
    if speedValue then
        getgenv().TargetSpeed = speedValue
        getgenv().LoopSpeedEnabled = true -- Kích hoạt vòng lặp khóa tốc độ
    else
        SpeedInput.Text = ""
        SpeedInput.PlaceholderText = "Hãy nhập số!"
    end
end)

-- Xử lý khi bấm nút Reset
ResetBtn.MouseButton1Click:Connect(function()
    getgenv().LoopSpeedEnabled = false -- Tắt vòng lặp khóa tốc độ
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        SpeedInput.Text = "16"
    end)
end)
