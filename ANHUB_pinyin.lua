

local TUPIAN_URLS = {
    IntroLogo = "https://raw.githubusercontent.com/Fe-ProjectR/GAME-IMAGES/refs/heads/main/Untitled230_20260713073832.png",
    PillLogo = "https://raw.githubusercontent.com/Fe-ProjectR/GAME-IMAGES/refs/heads/main/1000043901.png"
}

local YonghuShuruFuwu = game:GetService("UserInputService")
local DonghuaFuwu = game:GetService("TweenService")
local Wanjia = game:GetService("Players")
local JiemianFuwu = game:GetService("GuiService")
local HttpFuwu = game:GetService("HttpService")
local ChuansongFuwu = game:GetService("TeleportService")
local YunxingFuwu = game:GetService("RunService")
local WenbenFuwu = game:GetService("TextService")
local LocalPlayer = Wanjia.LocalPlayer
local WanjiaJiemian = LocalPlayer:WaitForChild("PlayerGui")
local Xiangji = workspace.CurrentCamera

-- 重复执行时先把旧界面清掉
local AN_HUANJING = (getgenv and getgenv()) or _G
if type(AN_HUANJING.AN_UNIVERSAL_CLEANUP) == "function" then
    pcall(AN_HUANJING.AN_UNIVERSAL_CLEANUP)
end
if AN_HUANJING.AN_UNIVERSAL_GUI then
    pcall(function()
        if AN_HUANJING.AN_UNIVERSAL_GUI.Parent then
            AN_HUANJING.AN_UNIVERSAL_GUI:Destroy()
        end
    end)
end
for _, existingGui in ipairs(WanjiaJiemian:GetChildren()) do
    if existingGui:IsA("ScreenGui") and existingGui.Name == "ANMenutwin" then
        pcall(function() existingGui:Destroy() end)
    end
end
local AN_ZHIXING_LINGPAI = tostring(os.time()) .. ":" .. tostring(math.random(100000, 999999))
AN_HUANJING.AN_UNIVERSAL_SESSION = AN_ZHIXING_LINGPAI
AN_HUANJING.AN_UNIVERSAL_GUI = nil

local JobId = game.JobId
if JobId == "" then JobId = "TestServer" end
local JICHU_URL = "https://anuni-21a0e-default-rtdb.firebaseio.com/"
local httpQingqiu = request or httpQingqiu or (syn and syn.request)

-- 权限等级 4 创始人 3 联合创始人 2 管理员 1 普通用户
local CHUANGZUOZHE_ID = 1494561843
local CO_CHUANGSHIREN_ID = 11084026865
local GUANLI_IDS = {
    0,
    0
}

local function HuodeYonghuDengji(userId)
    if userId == CHUANGZUOZHE_ID then return 4 end
    if userId == CO_CHUANGSHIREN_ID then return 3 end
    if table.find(GUANLI_IDS, userId) then return 2 end
    return 1
end

local function ShiGuanli(userId)
    return HuodeYonghuDengji(userId) >= 2
end

local XunhuanJishaMubiao = {}
local XuanzhuanMubiao = {}
local BingFangkuaiBujian = nil

-- 冰冻特效
local function chuangjianBingFangkuai(juese)
    if BingFangkuaiBujian then BingFangkuaiBujian:Destroy() BingFangkuaiBujian = nil end
    if not juese then return end
    local hrp = juese:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local cube = Instance.new("Part")
    cube.Name = "AN_IceCube"
    cube.Size = Vector3.new(5, 7, 5)
    cube.Material = Enum.Material.Ice
    cube.Color = Color3.fromRGB(130, 210, 255)
    cube.Transparency = 0.35
    cube.CanCollide = false
    cube.Anchored = false
    cube.CastShadow = false
    cube.Parent = workspace
    cube.CFrame = hrp.CFrame
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = hrp
    weld.Part1 = cube
    weld.Parent = cube

    local lizi = Instance.new("ParticleEmitter")
    lizi.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(200, 240, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(130, 200, 255)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(255, 255, 255))
    })
    lizi.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0,   0.25),
        NumberSequenceKeypoint.new(0.6, 0.12),
        NumberSequenceKeypoint.new(1,   0)
    })
    lizi.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,   0.2),
        NumberSequenceKeypoint.new(0.7, 0.5),
        NumberSequenceKeypoint.new(1,   1)
    })
    lizi.LightEmission  = 0.6
    lizi.LightInfluence = 0.3
    lizi.Speed          = NumberRange.new(1.5, 4)
    lizi.SpreadAngle    = Vector2.new(60, 60)
    lizi.Rate           = 30
    lizi.Lifetime       = NumberRange.new(0.8, 1.6)
    lizi.RotSpeed       = NumberRange.new(-60, 60)
    lizi.Rotation       = NumberRange.new(0, 360)
    lizi.Parent         = cube

    BingFangkuaiBujian = cube
end

local function yichuBingFangkuai()
    if not BingFangkuaiBujian then return end
    local cube = BingFangkuaiBujian
    BingFangkuaiBujian = nil

    for _, child in ipairs(cube:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            child.Enabled = false
        end
    end

    local shuiwaZuobiao = cube.CFrame.Position

    DonghuaFuwu:Create(cube, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size        = Vector3.new(5.5, 0.05, 5.5),
        Transparency = 0.92,
        Color       = Color3.fromRGB(90, 160, 210)
    }):Play()

    task.spawn(function()

        task.wait(0.35)

        local shuiwa = Instance.new("Part")
        shuiwa.Name        = "AN_IcePuddle"
        shuiwa.Size        = Vector3.new(0.5, 0.05, 0.5)
        shuiwa.Material    = Enum.Material.SmoothPlastic
        shuiwa.Color       = Color3.fromRGB(100, 180, 230)
        shuiwa.Transparency = 0.35
        shuiwa.CanCollide  = false
        shuiwa.Anchored    = true
        shuiwa.CastShadow  = false
        shuiwa.Position    = Vector3.new(shuiwaZuobiao.X, shuiwaZuobiao.Y - 3, shuiwaZuobiao.Z)
        shuiwa.Parent      = workspace

        DonghuaFuwu:Create(shuiwa, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(6, 0.05, 6)
        }):Play()

        task.wait(0.6)
        DonghuaFuwu:Create(shuiwa, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(6.8, 0.05, 6.8),
            Transparency = 0.45
        }):Play()
        task.wait(0.4)
        DonghuaFuwu:Create(shuiwa, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Size = Vector3.new(6, 0.05, 6),
            Transparency = 0.35
        }):Play()

        task.wait(3.8)
        DonghuaFuwu:Create(shuiwa, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size         = Vector3.new(3.5, 0.05, 3.5)
        }):Play()
        task.wait(1.2)
        if shuiwa and shuiwa.Parent then shuiwa:Destroy() end
    end)

    task.delay(0.9, function()
        if cube and cube.Parent then cube:Destroy() end
    end)
end

-- 封禁时长 10min / 2hr / 1yr
local function fenxiShichang(shichangZifuchuan)
    if not shichangZifuchuan or shichangZifuchuan == "-1" then return -1 end

    local num = tonumber(shichangZifuchuan:match("%d+"))
    local unit = shichangZifuchuan:match("%a+"):lower()
    if not num then return -1 end

    if unit:find("min") then return num * 60
    elseif unit:find("hr") then return num * 3600
    elseif unit:find("yr") then return num * 31536000
    end
    return -1
end

local function geshiShengyuShijian(expiresTimestamp)
    if expiresTimestamp == -1 then return "Permanent" end
    local shengyu = expiresTimestamp - os.time()
    if shengyu <= 0 then return "Expired" end

    local days = math.floor(shengyu / 86400)
    local xiaoshi = math.floor((shengyu % 86400) / 3600)
    local fenzhong = math.floor((shengyu % 3600) / 60)

    if days > 0 then return string.format("%d days, %d hours", days, xiaoshi)
    elseif xiaoshi > 0 then return string.format("%d hours, %d minutes", xiaoshi, fenzhong)
    else return string.format("%d minutes", fenzhong)
    end
end

-- 在线心跳 每30秒写一次 Firebase
local function jianchaZai()
    if not httpQingqiu then return end
    task.spawn(function()
        while AN_HUANJING.AN_UNIVERSAL_SESSION == AN_ZHIXING_LINGPAI do
            local yonghuUrl = JICHU_URL .. "active_users/" .. JobId .. "/" .. tostring(LocalPlayer.UserId) .. ".json"
            local data = HttpFuwu:JSONEncode({
                username = LocalPlayer.Name,
                timestamp = os.time()
            })

            httpQingqiu({
                Url = yonghuUrl,
                Method = "PUT",
                Headers = {["Content-Type"] = "application/json"},
                Body = data
            })

            task.wait(30)
        end
    end)
end

local function jianchaChu()
    if not httpQingqiu then return end
    local yonghuUrl = JICHU_URL .. "active_users/" .. JobId .. "/" .. tostring(LocalPlayer.UserId) .. ".json"
    httpQingqiu({
        Url = yonghuUrl,
        Method = "DELETE"
    })
end

Wanjia.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        jianchaChu()
    end
end)

pcall(function()
    if makefolder and isfolder and not isfolder("AN") then
        makefolder("AN")
    end
end)

local ZIDONG_ZHIXING_LOADSTRING = [[
loadstring(game:HttpGet('https://raw.githubusercontent.com/GUI-Offical/FileTest/refs/heads/main/ANHUBB.lua'))()
]]

local SHENGYIN_URLS = {
    Intro = "https://github.com/Fe-ProjectR/GAME-IMAGES/raw/refs/heads/main/dragon-studio-dramatic-youtube-intro-478365.mp3",
    Hover = "https://github.com/Fe-ProjectR/GAME-IMAGES/raw/refs/heads/main/lesiakower-minimalist-button-hover-sound-effect-399749.mp3",
    Click = "https://github.com/Fe-ProjectR/GAME-IMAGES/raw/refs/heads/main/666herohero-click-21156.mp3"
}

local YUNDUAN_DIANYING_URL = "https://raw.githubusercontent.com/GUICLOUDS/CloudStorage/refs/heads/main/movies.json?nocache=" .. os.time()
local shiYonghuYifeng = false
local fengjinShijianWenben = ""

if httpQingqiu then
    local heimingdanJiancha = httpQingqiu({
        Url = JICHU_URL .. "blacklist/" .. tostring(LocalPlayer.UserId) .. ".json",
        Method = "GET"
    })

    if heimingdanJiancha and heimingdanJiancha.StatusCode == 200 and heimingdanJiancha.Body ~= "null" then
        local fengjinShuju = HttpFuwu:JSONDecode(heimingdanJiancha.Body)
        if fengjinShuju then
            if fengjinShuju.expires == -1 or fengjinShuju.expires > os.time() then
                shiYonghuYifeng = true
                fengjinShijianWenben = geshiShengyuShijian(fengjinShuju.expires)
            else
                httpQingqiu({
                    Url = JICHU_URL .. "blacklist/" .. tostring(LocalPlayer.UserId) .. ".json",
                    Method = "DELETE"
                })
            end
        end
    end
end

local Dianying = {}
local BiaozhiShuliang = {}
local WeiyiBiaozhi = {}
local ZuihouDianyingShuju = nil
local gengxinLunbo

-- 从 GitHub 拉电影列表
local function HuoquDianying()
    pcall(function()
        local res = game:HttpGet(YUNDUAN_DIANYING_URL)
        if res ~= ZuihouDianyingShuju then
            local shiGengxin = ZuihouDianyingShuju ~= nil
            ZuihouDianyingShuju = res
            local decoded = HttpFuwu:JSONDecode(res)
            if decoded and type(decoded) == "table" and #decoded > 0 then
                Dianying = decoded
                BiaozhiShuliang = {}
                WeiyiBiaozhi = {}
                for _, dianying in ipairs(Dianying) do
                    local fenxiBiaozhi = {}
                    if dianying.Tags then
                        if type(dianying.Tags) == "string" then
                            for t in string.gmatch(dianying.Tags, "([^,]+)") do
                                local jianqu = t:match("^%s*(.-)%s*$")
                                if jianqu ~= "" then table.insert(fenxiBiaozhi, jianqu) end
                            end
                        elseif type(dianying.Tags) == "table" then
                            for _, t in ipairs(dianying.Tags) do
                                local jianqu = tostring(t):match("^%s*(.-)%s*$")
                                if jianqu ~= "" then table.insert(fenxiBiaozhi, jianqu) end
                            end
                        end
                    end

                    dianying.ParsedTags = fenxiBiaozhi

                    for _, t in ipairs(fenxiBiaozhi) do
                        if not BiaozhiShuliang[t] then
                            BiaozhiShuliang[t] = 0
                            table.insert(WeiyiBiaozhi, t)
                        end
                        BiaozhiShuliang[t] = BiaozhiShuliang[t] + 1
                    end
                end
                table.sort(WeiyiBiaozhi)

                if shiGengxin and gengxinLunbo then
                    gengxinLunbo()
                end
                return shiGengxin
            end
        end
    end)
    return false
end
HuoquDianying()

-- 本地收藏
local SHOUCANG_WENJIAN = "AN/NFX_MyList.json"
local Shoucang = {}

pcall(function()
    if isfile and readfile and isfile(SHOUCANG_WENJIAN) then
        local decoded = HttpFuwu:JSONDecode(readfile(SHOUCANG_WENJIAN))
        if type(decoded) == "table" then
            for _, entry in ipairs(decoded) do
                if type(entry) == "string" then
                    table.insert(Shoucang, {Kind = "movie", Title = entry})
                elseif type(entry) == "table" and entry.Title then
                    entry.Kind = entry.Kind or "movie"
                    table.insert(Shoucang, entry)
                end
            end
        end
    end
end)

local function baocunShoucang()
    pcall(function()
        if writefile then writefile(SHOUCANG_WENJIAN, HttpFuwu:JSONEncode(Shoucang)) end
    end)
end

function chazhaoShoucangSuoyin(title, kind)
    title = tostring(title or "")
    kind = kind or "movie"
    for i, entry in ipairs(Shoucang) do
        if type(entry) == "table" and tostring(entry.Title or "") == title and (entry.Kind or "movie") == kind then
            return i
        end
    end
    return nil
end

local function shiShoucang(movieTitle)
    return chazhaoShoucangSuoyin(movieTitle, "movie") ~= nil
end

local function qiehuanShoucang(movieTitle)
    local suoyin = chazhaoShoucangSuoyin(movieTitle, "movie")
    if suoyin then
        table.remove(Shoucang, suoyin)
    else
        table.insert(Shoucang, {Kind = "movie", Title = movieTitle})
    end
    baocunShoucang()
end

function shiDaobanShoucang(title)
    return chazhaoShoucangSuoyin(title, "pirated") ~= nil
end

function qiehuanDaobanShoucang(scriptData, comments)
    if not scriptData then return end
    local title = tostring(scriptData.title or "Untitled Script")
    local suoyin = chazhaoShoucangSuoyin(title, "pirated")
    if suoyin then
        table.remove(Shoucang, suoyin)
    else
        local biaozhiFuzhi = {}
        if type(scriptData.tags) == "table" then
            for _, tag in ipairs(scriptData.tags) do table.insert(biaozhiFuzhi, tostring(tag)) end
        end
        local pinglunFuzhi = {}
        if type(comments) == "table" then
            for _, comment in ipairs(comments) do table.insert(pinglunFuzhi, comment) end
        end
        table.insert(Shoucang, {
            Kind = "pirated",
            Title = title,
            Script = type(scriptData.script) == "string" and scriptData.script or "",
            Image = scriptData.image or (scriptData.game and scriptData.game.imageUrl) or "",
            Game = scriptData.game,
            Description = scriptData.features or scriptData.description or "No description provided.",
            Likes = tonumber(scriptData.likeCount) or 0,
            Dislikes = tonumber(scriptData.dislikeCount) or 0,
            Views = tonumber(scriptData.views) or 0,
            Owner = scriptData.owner and scriptData.owner.username or "Unknown",
            UpdatedAt = scriptData.updatedAt,
            CreatedAt = scriptData.createdAt,
            Tags = biaozhiFuzhi,
            Verified = scriptData.verified == true,
            Key = scriptData.key == true,
            Universal = scriptData.isUniversal == true,
            Patched = scriptData.isPatched == true,
            ScriptType = scriptData.scriptType,
            Visibility = scriptData.visibility,
            Slug = scriptData.slug,
            Id = scriptData._id,
            Comments = pinglunFuzhi
        })
    end
    baocunShoucang()
end

function huodeYibaocunDaobanTiaomu()
    local tiaomu = {}
    for _, entry in ipairs(Shoucang) do
        if type(entry) == "table" and (entry.Kind == "pirated") then
            table.insert(tiaomu, entry)
        end
    end
    return tiaomu
end

baocunShoucang()

local PEIZHI_WENJIAN = "AN/NFX_Settings.json"
local Shezhi = { ShowTags = true }

pcall(function()
    if isfile and readfile and isfile(PEIZHI_WENJIAN) then
        local decoded = HttpFuwu:JSONDecode(readfile(PEIZHI_WENJIAN))
        if decoded then for k, v in pairs(decoded) do Shezhi[k] = v end end
    end
end)

local function baocunShezhi()
    pcall(function()
        if writefile then writefile(PEIZHI_WENJIAN, HttpFuwu:JSONEncode(Shezhi)) end
    end)
end

local CHUANGKOU_PEIZHI_WENJIAN = "AN/NFX_WindowConfig.json"
local ChuangkouPeizhi = { Width = 720, Height = 460 }

pcall(function()
    if isfile and readfile and isfile(CHUANGKOU_PEIZHI_WENJIAN) then
        local decoded = HttpFuwu:JSONDecode(readfile(CHUANGKOU_PEIZHI_WENJIAN))
        if decoded then
            ChuangkouPeizhi.Width = decoded.Width or ChuangkouPeizhi.Width
            ChuangkouPeizhi.Height = decoded.Height or ChuangkouPeizhi.Height
        end
    end
end)

local ZHUTI_WENJIAN = "AN/NFX_ThemeColor.txt"
local DangqianZhutiShiliu = "E50914"

pcall(function()
    if isfile and readfile and isfile(ZHUTI_WENJIAN) then
        DangqianZhutiShiliu = readfile(ZHUTI_WENJIAN)
    end
end)

local DangqianZhutiYanse = Color3.fromHex(DangqianZhutiShiliu)
local gengxinDongtaiZhutiYanse
local yingyongXinZhuti
local DaobanTupianWenjian = {}
local DaobanTupianDaishu = 0

local function huodeTupianKuozhanmingCongNeirongZhonglei(neirongZhonglei)
    neirongZhonglei = tostring(neirongZhonglei or ""):lower():match("^[^;]+") or ""
    local map = {
        ["image/png"] = "png",
        ["image/jpeg"] = "jpg",
        ["image/jpg"] = "jpg",
        ["image/webp"] = "webp",
        ["image/gif"] = "gif",
        ["image/bmp"] = "bmp",
        ["image/x-bmp"] = "bmp"
    }
    return map[neirongZhonglei]
end

local function huodeTupianKuozhanmingCongUrl(url)
    local qingliUrl = tostring(url or ""):match("^[^?#]+") or tostring(url or "")
    local ext = qingliUrl:match("%.([%a%d]+)$")
    if ext then
        ext = ext:lower()
        if ext == "jpeg" then ext = "jpg" end
        if ext == "png" or ext == "jpg" or ext == "webp" or ext == "gif" or ext == "bmp" then
            return ext
        end
    end
    return nil
end

local function huodeTupianKuozhanmingCongZijie(data)
    if type(data) ~= "string" or data == "" then return nil end
    if data:sub(1, 8) == "\137PNG\r\n\26\n" then return "png" end
    if data:sub(1, 3) == "\255\216\255" then return "jpg" end
    if data:sub(1, 4) == "RIFF" and data:sub(9, 12) == "WEBP" then return "webp" end
    if data:sub(1, 4) == "GIF8" then return "gif" end
    if data:sub(1, 2) == "BM" then return "bmp" end
    return nil
end

local function huodeTupianHuancunShuju(url)
    if httpQingqiu then
        local ok, response = pcall(function()
            return httpQingqiu({Url = url, Method = "GET"})
        end)
        if ok and response and response.Body then
            local ztDaima = tonumber(response.StatusCode or response.status_code or response.Status)
            if not ztDaima or (ztDaima >= 200 and ztDaima < 300) then
                local headers = response.Headers or response.headers or {}
                local neirongZhonglei = headers["Content-Type"] or headers["content-type"] or headers["CONTENT-TYPE"]
                local body = response.Body
                return body, huodeTupianKuozhanmingCongNeirongZhonglei(neirongZhonglei) or huodeTupianKuozhanmingCongZijie(body)
            end
        end
    end

    local ok, data = pcall(function()
        return game:HttpGet(url)
    end)
    if ok and data then
        return data, huodeTupianKuozhanmingCongZijie(data)
    end
    return nil, nil
end

local function anquanTupianHuancunMingzi(url)
    local anquanUrl = tostring(url or ""):gsub("[^%w]", "")
    if #anquanUrl > 64 then anquanUrl = anquanUrl:sub(-64) end
    if anquanUrl == "" then anquanUrl = "image" end
    return anquanUrl
end

local function qingkongDaobanTupianHuancun()
    DaobanTupianDaishu = DaobanTupianDaishu + 1
    for wenjianLujing in pairs(DaobanTupianWenjian) do
        pcall(function()
            if delfile and isfile and isfile(wenjianLujing) then delfile(wenjianLujing) end
        end)
    end
    DaobanTupianWenjian = {}

    pcall(function()
        if listfiles and delfile and isfile then
            for _, wenjianLujing in ipairs(listfiles("AN")) do
                local guiyi = tostring(wenjianLujing):gsub("\\", "/")
                if guiyi:match("^AN/NFX_PIRATED_IMG_") then
                    if isfile(wenjianLujing) then delfile(wenjianLujing) end
                end
            end
        end
    end)
end

qingkongDaobanTupianHuancun()

-- 图片先存到本地再用 getcustomasset 读
local function JiazaiTupianYibu(imageLabel, url, skipFade, temporaryPirated)
    if not url or url == "" then return end
    if not skipFade then imageLabel.ImageTransparency = 1 end
    if not (url:find("^http://") or url:find("^https://")) then
        imageLabel.Image = url
        if not skipFade then DonghuaFuwu:Create(imageLabel, TweenInfo.new(0.35), {ImageTransparency = 0}):Play() end
        return
    end

    local tupianDaishu = DaobanTupianDaishu
    task.spawn(function()
        local huodeZiyuan = getcustomasset or getsynasset
        if not (writefile and isfile and huodeZiyuan) then return end

        local hintedKuozhanming = huodeTupianKuozhanmingCongUrl(url)
        local anquanMingzi = anquanTupianHuancunMingzi(url)
        local qianzhui = temporaryPirated and "AN/NFX_PIRATED_IMG_" or "AN/NFX_IMG_"
        local wenjianLujing = nil
        local data = nil
        local detectedExtension = nil

        if temporaryPirated and tupianDaishu ~= DaobanTupianDaishu then return end

        if hintedKuozhanming then
            wenjianLujing = qianzhui .. anquanMingzi .. "." .. hintedKuozhanming
        end

        if not wenjianLujing or not isfile(wenjianLujing) then
            data, detectedExtension = huodeTupianHuancunShuju(url)
            if not data then return end
            local kuozhanming = detectedExtension or hintedKuozhanming or "png"
            wenjianLujing = qianzhui .. anquanMingzi .. "." .. kuozhanming
            if temporaryPirated and tupianDaishu ~= DaobanTupianDaishu then return end
            local xieru = pcall(function() writefile(wenjianLujing, data) end)
            if not xieru then return end
        end

        if temporaryPirated then
            if tupianDaishu ~= DaobanTupianDaishu then
                pcall(function()
                    if delfile and isfile and isfile(wenjianLujing) then delfile(wenjianLujing) end
                end)
                return
            end
            DaobanTupianWenjian[wenjianLujing] = true
        end

        if isfile(wenjianLujing) and imageLabel and imageLabel.Parent then
            local ok, asset = pcall(function() return huodeZiyuan(wenjianLujing) end)
            if ok and asset then
                imageLabel.Image = asset
                if not skipFade then DonghuaFuwu:Create(imageLabel, TweenInfo.new(0.4), {ImageTransparency = 0}):Play() end
            end
        end
    end)
end

local SHENGYIN_HUANCUN = {}
-- 音效缓存
local function BofangShengyinYibu(url, name, vol)
    if not url or url == "" then return end
    task.spawn(function()
        local huodeZiyuan = getcustomasset or getsynasset
        if not (writefile and isfile and huodeZiyuan) then return end
        local anquanMingzi = name:gsub("[^%w]", "")
        local wenjianLujing = "AN/NFX_SND_" .. anquanMingzi .. ".mp3"

        if not SHENGYIN_HUANCUN[name] then
            if not isfile(wenjianLujing) then
                local chenggong, data = pcall(function() return game:HttpGet(url) end)
                if chenggong and data then writefile(wenjianLujing, data) else return end
            end
            if isfile(wenjianLujing) then SHENGYIN_HUANCUN[name] = huodeZiyuan(wenjianLujing) end
        end

        if SHENGYIN_HUANCUN[name] then
            local sfx = Instance.new("Sound")
            sfx.SoundId = SHENGYIN_HUANCUN[name]
            sfx.Volume = vol or 1
            sfx.Parent = workspace
            sfx:Play()
            sfx.Ended:Connect(function() sfx:Destroy() end)
        end
    end)
end

local function BangdingJiaohuShengyin(guiElement)
    if not guiElement:IsA("GuiButton") then return end
    guiElement.MouseEnter:Connect(function() BofangShengyinYibu(SHENGYIN_URLS.Hover, "Hover", 0.3) end)
    guiElement.MouseButton1Click:Connect(function() BofangShengyinYibu(SHENGYIN_URLS.Click, "Click", 0.6) end)
end

task.spawn(function()
    BofangShengyinYibu(SHENGYIN_URLS.Intro, "Intro", 0)
    BofangShengyinYibu(SHENGYIN_URLS.Hover, "Hover", 0)
    BofangShengyinYibu(SHENGYIN_URLS.Click, "Click", 0)
end)

local Yanse = {
    DarkBack = Color3.fromRGB(12, 12, 12),
    DarkMid = Color3.fromRGB(18, 18, 18),
    DarkCard = Color3.fromRGB(26, 26, 26),
    Border = Color3.fromRGB(38, 38, 38),
    BrandRed = DangqianZhutiYanse,
    White = Color3.fromRGB(255, 255, 255),
    GreyMuted = Color3.fromRGB(130, 130, 130),
    GreyLight = Color3.fromRGB(180, 180, 180)
}

local Ziti = {
    Heavy = Enum.Font.GothamBlack,
    Bold = Enum.Font.GothamBold,
    Medium = Enum.Font.GothamMedium,
    Book = Enum.Font.Gotham
}

function wodeLiebiaoBiaoqian(zaiLiebiao)
    return zaiLiebiao and "\u{2713} My List" or "+ My List"
end

local function chuangjianYuanjiao(parent, radius)
    local yuanjiao = Instance.new("UICorner")
    yuanjiao.CornerRadius = UDim.new(0, radius or 6)
    yuanjiao.Parent = parent
    return yuanjiao
end

local function chuangjianMiaobian(parent, color, thickness, transparency)
    local miaobian = Instance.new("UIStroke")
    miaobian.Color = color or Yanse.Border
    miaobian.Thickness = thickness or 1
    miaobian.Transparency = transparency or 0
    miaobian.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    miaobian.Parent = parent
    return miaobian
end

local function duilieZidongZhixing()
    local q = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
    if q then q(ZIDONG_ZHIXING_LOADSTRING) end
end

local function shiShouji2()
    return YonghuShuruFuwu.TouchEnabled and not YonghuShuruFuwu.MouseEnabled
end

local function huodeMubiaoDaxiao()
    local shikou = Xiangji.ViewportSize
    local kuandu = ChuangkouPeizhi.Width
    local height = ChuangkouPeizhi.Height

    if shiShouji2() then

        local suofang = math.clamp(shikou.X / 1200, 0.4, 0.85)
        return UDim2.new(0, kuandu * suofang, 0, height * suofang)
    elseif shikou.X < 750 then

        local suofang = math.clamp(shikou.X / 750, 0.5, 0.85)
        return UDim2.new(0, kuandu * suofang, 0, height * suofang)
    end
    return UDim2.new(0, kuandu, 0, height)
end

local PingmuJiemian = Instance.new("ScreenGui")
PingmuJiemian.Name = "ANMenutwin"
PingmuJiemian.ResetOnSpawn = false
PingmuJiemian.IgnoreGuiInset = true
PingmuJiemian.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PingmuJiemian.Parent = WanjiaJiemian
AN_HUANJING.AN_UNIVERSAL_GUI = PingmuJiemian
AN_HUANJING.AN_UNIVERSAL_CLEANUP = function()
    pcall(function()
        if AN_HUANJING.AN_UNIVERSAL_GUI == PingmuJiemian then
            AN_HUANJING.AN_UNIVERSAL_GUI = nil
        end
    end)
    pcall(function() qingkongDaobanTupianHuancun() end)
    pcall(function() jianchaChu() end)
    pcall(function()
        if PingmuJiemian.Parent then PingmuJiemian:Destroy() end
    end)
end

local function ZhanshiNetflixTongzhi(title, desc)
    local TongzhiKuangjia = Instance.new("Frame")
    TongzhiKuangjia.Size = UDim2.new(0, 320, 0, 70)
    TongzhiKuangjia.Position = UDim2.new(1, 10, 1, -90)
    TongzhiKuangjia.AnchorPoint = Vector2.new(1, 1)
    TongzhiKuangjia.BackgroundColor3 = Yanse.DarkBack
    TongzhiKuangjia.BorderSizePixel = 0
    TongzhiKuangjia.ZIndex = 200
    TongzhiKuangjia.Parent = PingmuJiemian
    chuangjianYuanjiao(TongzhiKuangjia, 6)
    chuangjianMiaobian(TongzhiKuangjia, Yanse.BrandRed, 2)

    local NTubiao = Instance.new("TextLabel")
    NTubiao.Size = UDim2.new(0, 40, 0, 40)
    NTubiao.Position = UDim2.new(0, 15, 0.5, -20)
    NTubiao.BackgroundTransparency = 1
    NTubiao.Text = "N"
    NTubiao.TextColor3 = Yanse.BrandRed
    NTubiao.Font = Ziti.Heavy
    NTubiao.TextSize = 28
    NTubiao.ZIndex = 201
    NTubiao.Parent = TongzhiKuangjia

    local BiaotiBq = Instance.new("TextLabel")
    BiaotiBq.Size = UDim2.new(1, -70, 0, 20)
    BiaotiBq.Position = UDim2.new(0, 60, 0, 15)
    BiaotiBq.BackgroundTransparency = 1
    BiaotiBq.Text = title
    BiaotiBq.TextColor3 = Yanse.White
    BiaotiBq.Font = Ziti.Bold
    BiaotiBq.TextSize = 14
    BiaotiBq.TextXAlignment = Enum.TextXAlignment.Left
    BiaotiBq.ZIndex = 201
    BiaotiBq.Parent = TongzhiKuangjia

    local MiaoshuBq = Instance.new("TextLabel")
    MiaoshuBq.Size = UDim2.new(1, -70, 0, 20)
    MiaoshuBq.Position = UDim2.new(0, 60, 0, 35)
    MiaoshuBq.BackgroundTransparency = 1
    MiaoshuBq.Text = desc
    MiaoshuBq.TextColor3 = Yanse.GreyLight
    MiaoshuBq.Font = Ziti.Book
    MiaoshuBq.TextSize = 12
    MiaoshuBq.TextXAlignment = Enum.TextXAlignment.Left
    MiaoshuBq.ZIndex = 201
    MiaoshuBq.Parent = TongzhiKuangjia

    BofangShengyinYibu(SHENGYIN_URLS.Intro, "Intro", 0.5)

    DonghuaFuwu:Create(TongzhiKuangjia, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -20, 1, -90)
    }):Play()

    task.delay(4, function()
        local chuDonghua = DonghuaFuwu:Create(TongzhiKuangjia, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 10, 1, -90)
        })
        chuDonghua:Play()
        chuDonghua.Completed:Wait()
        if TongzhiKuangjia then TongzhiKuangjia:Destroy() end
    end)
end

task.spawn(function()
    while task.wait(60) do
        if HuoquDianying() then
            ZhanshiNetflixTongzhi("Script Update Detected", "The movies list has been updated on GitHub.")
        end
    end
end)

local kaishiDaxiao = huodeMubiaoDaxiao()
local ZhuKuangjia = Instance.new("Frame")
ZhuKuangjia.Name = "MainFrame"
ZhuKuangjia.Size = kaishiDaxiao
ZhuKuangjia.Position = UDim2.new(0.5, -kaishiDaxiao.X.Offset / 2, 0.5, -kaishiDaxiao.Y.Offset / 2)
ZhuKuangjia.BackgroundColor3 = Yanse.DarkBack
ZhuKuangjia.BorderSizePixel = 0
ZhuKuangjia.ClipsDescendants = true
ZhuKuangjia.Parent = PingmuJiemian
chuangjianYuanjiao(ZhuKuangjia, 10)
chuangjianMiaobian(ZhuKuangjia, Yanse.Border, 1, 0.3)

-- 拖动窗口
local function zhizuoKetuo(dragHandle, mubiao)
    local tuozhong = false
    local tuodongShuru, kaishiZuobiao, kaishiShuruZuobiao
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            tuozhong = true
            kaishiZuobiao = mubiao.Position
            kaishiShuruZuobiao = input.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    tuozhong = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            tuodongShuru = input
        end
    end)

    YonghuShuruFuwu.InputChanged:Connect(function(input)
        if input == tuodongShuru and tuozhong then
            local chazhi = input.Position - kaishiShuruZuobiao
            mubiao.Position = UDim2.new(
                kaishiZuobiao.X.Scale, kaishiZuobiao.X.Offset + chazhi.X,
                kaishiZuobiao.Y.Scale, kaishiZuobiao.Y.Offset + chazhi.Y
            )
        end
    end)
end

do
    local PianTouKuangjia = Instance.new("Frame")
    PianTouKuangjia.Name = "IntroFrame"
    PianTouKuangjia.Size = UDim2.new(1, 0, 1, 0)
    PianTouKuangjia.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    PianTouKuangjia.BorderSizePixel = 0
    PianTouKuangjia.ZIndex = 50
    PianTouKuangjia.Parent = ZhuKuangjia
    chuangjianYuanjiao(PianTouKuangjia, 10)

    local JiazaizhongN = Instance.new("ImageLabel")
    JiazaizhongN.Name = "LoadingAN"
    JiazaizhongN.Size = UDim2.new(0, 100, 0, 100)
    JiazaizhongN.Position = UDim2.new(0.5, -50, 0.45, -50)
    JiazaizhongN.BackgroundTransparency = 1
    JiazaizhongN.ImageTransparency = 1
    JiazaizhongN.ZIndex = 51
    JiazaizhongN.Parent = PianTouKuangjia
    JiazaiTupianYibu(JiazaizhongN, TUPIAN_URLS.IntroLogo, true)

    local JiazaiTiao = Instance.new("Frame")
    JiazaiTiao.Name = "LoadBar"
    JiazaiTiao.Size = UDim2.new(0, 0, 0, 3)
    JiazaiTiao.Position = UDim2.new(0.5, -60, 0.72, 0)
    JiazaiTiao.BackgroundColor3 = Yanse.BrandRed
    JiazaiTiao.BorderSizePixel = 0
    JiazaiTiao.ZIndex = 51
    JiazaiTiao.Parent = PianTouKuangjia
    chuangjianYuanjiao(JiazaiTiao, 1.5)

    BofangShengyinYibu(SHENGYIN_URLS.Intro, "Intro", 1.2)
    JiazaizhongN.Size = UDim2.new(0, 60, 0, 60)
    JiazaizhongN.Position = UDim2.new(0.5, -30, 0.45, -30)
    DonghuaFuwu:Create(JiazaizhongN, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 100, 0, 100),
        Position = UDim2.new(0.5, -50, 0.45, -50),
        ImageTransparency = 0
    }):Play()

    task.wait(0.3)
    DonghuaFuwu:Create(JiazaiTiao, TweenInfo.new(0.9, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 120, 0, 3)
    }):Play()

    task.wait(1.0)
    DonghuaFuwu:Create(JiazaizhongN, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 400, 0, 400),
        Position = UDim2.new(0.5, -200, 0.45, -200),
        ImageTransparency = 1
    }):Play()

    DonghuaFuwu:Create(JiazaiTiao, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play()

    local danchuBeijing = DonghuaFuwu:Create(PianTouKuangjia, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    })
    danchuBeijing:Play()
    danchuBeijing.Completed:Wait()
    PianTouKuangjia:Destroy()
end

local BiaotouTiao = Instance.new("Frame")
BiaotouTiao.Name = "HeaderBar"
BiaotouTiao.Size = UDim2.new(1, 0, 0, 52)
BiaotouTiao.BackgroundColor3 = Yanse.DarkMid
BiaotouTiao.BorderSizePixel = 0
BiaotouTiao.ZIndex = 10
BiaotouTiao.Parent = ZhuKuangjia

do
    local BiaotouDibuZhegai = Instance.new("Frame")
    BiaotouDibuZhegai.Size = UDim2.new(1, 0, 0, 10)
    BiaotouDibuZhegai.Position = UDim2.new(0, 0, 1, -10)
    BiaotouDibuZhegai.BackgroundColor3 = Yanse.DarkMid
    BiaotouDibuZhegai.BorderSizePixel = 0
    BiaotouDibuZhegai.ZIndex = 10
    BiaotouDibuZhegai.Parent = BiaotouTiao
end

local PinpaiLogo = Instance.new("TextLabel")
PinpaiLogo.Name = "BrandLogo"
PinpaiLogo.Size = UDim2.new(0, 170, 1, 0)
PinpaiLogo.Position = UDim2.new(0, 18, 0, 0)
PinpaiLogo.BackgroundTransparency = 1
PinpaiLogo.Text = "AN UNIVERSAL"
PinpaiLogo.Font = Ziti.Heavy
PinpaiLogo.TextSize = 20
PinpaiLogo.TextColor3 = Yanse.BrandRed
PinpaiLogo.TextXAlignment = Enum.TextXAlignment.Left
PinpaiLogo.ZIndex = 11
PinpaiLogo.Parent = BiaotouTiao

local XiangkaDaohangRongqi = Instance.new("ScrollingFrame")
XiangkaDaohangRongqi.Name = "TabNavContainer"
XiangkaDaohangRongqi.Size = UDim2.new(1, -260, 1, 0)
XiangkaDaohangRongqi.Position = UDim2.new(0, 180, 0, 0)
XiangkaDaohangRongqi.BackgroundTransparency = 1
XiangkaDaohangRongqi.ScrollBarThickness = 0
XiangkaDaohangRongqi.ZIndex = 11
XiangkaDaohangRongqi.Parent = BiaotouTiao

do
    local XiangkaDaohangBuju = Instance.new("UIListLayout")
    XiangkaDaohangBuju.FillDirection = Enum.FillDirection.Horizontal
    XiangkaDaohangBuju.HorizontalAlignment = Enum.HorizontalAlignment.Left
    XiangkaDaohangBuju.VerticalAlignment = Enum.VerticalAlignment.Center
    XiangkaDaohangBuju.Padding = UDim.new(0, 14)
    XiangkaDaohangBuju.Parent = XiangkaDaohangRongqi

    XiangkaDaohangBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        XiangkaDaohangRongqi.CanvasSize = UDim2.new(0, XiangkaDaohangBuju.AbsoluteContentSize.X + 20, 0, 0)
    end)
end

local DaohangZhishi = Instance.new("Frame")
DaohangZhishi.Name = "NavIndicator"
DaohangZhishi.Size = UDim2.new(0, 0, 0, 2)
DaohangZhishi.Position = UDim2.new(0, 0, 1, -6)
DaohangZhishi.BackgroundColor3 = Yanse.BrandRed
DaohangZhishi.BorderSizePixel = 0
DaohangZhishi.ZIndex = 12
DaohangZhishi.Parent = BiaotouTiao

local function zhizuoWenbenXiangka(name, kuandu)
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.BackgroundTransparency = 1
    tab.Size = UDim2.new(0, kuandu or 65, 0, 24)
    tab.Text = name
    tab.Font = Ziti.Medium
    tab.TextSize = 13
    tab.TextColor3 = Yanse.GreyMuted
    tab.AutoButtonColor = false
    tab.ZIndex = 12
    tab.Parent = XiangkaDaohangRongqi
    BangdingJiaohuShengyin(tab)
    return tab
end

local DianyingXiangka = zhizuoWenbenXiangka("Movies", 55)
local ZhixingqiXiangka = zhizuoWenbenXiangka("Director's Cut", 100)
local DaobanXiangka = zhizuoWenbenXiangka("Pirated", 60)
local ShezhiXiangka = zhizuoWenbenXiangka("Settings", 65)
local MingdanXiangka = zhizuoWenbenXiangka("Credits", 55)
local GuanliXiangka
if ShiGuanli(LocalPlayer.UserId) then
    GuanliXiangka = zhizuoWenbenXiangka("Admin", 55)
end

local function gengxinXiangkaHang(targetTab)
    local absoluteZuobiao = targetTab.AbsolutePosition
    local xiangduiX = absoluteZuobiao.X - ZhuKuangjia.AbsolutePosition.X
    DonghuaFuwu:Create(DaohangZhishi, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, targetTab.AbsoluteSize.X, 0, 2),
        Position = UDim2.new(0, xiangduiX, 0, 46)
    }):Play()

    local quanXiangka = {DianyingXiangka, ZhixingqiXiangka, DaobanXiangka, ShezhiXiangka, MingdanXiangka}
    if GuanliXiangka then table.insert(quanXiangka, GuanliXiangka) end

    for _, otherTab in ipairs(quanXiangka) do
        local huoyue = (otherTab == targetTab)
        DonghuaFuwu:Create(otherTab, TweenInfo.new(0.2), {
            TextColor3 = huoyue and Yanse.White or Yanse.GreyMuted
        }):Play()
    end
end

local SuoxiaoBtn = Instance.new("TextButton")
do
    local DongzuoRongna = Instance.new("Frame")
    DongzuoRongna.Name = "ActionsHolder"
    DongzuoRongna.Size = UDim2.new(0, 70, 1, 0)
    DongzuoRongna.Position = UDim2.new(1, -82, 0, 0)
    DongzuoRongna.BackgroundTransparency = 1
    DongzuoRongna.ZIndex = 11
    DongzuoRongna.Parent = BiaotouTiao

    local DongzuoBuju = Instance.new("UIListLayout")
    DongzuoBuju.FillDirection = Enum.FillDirection.Horizontal
    DongzuoBuju.HorizontalAlignment = Enum.HorizontalAlignment.Right
    DongzuoBuju.VerticalAlignment = Enum.VerticalAlignment.Center
    DongzuoBuju.Padding = UDim.new(0, 10)
    DongzuoBuju.Parent = DongzuoRongna

    SuoxiaoBtn.Name = "MinimizeBtn"
    SuoxiaoBtn.Size = UDim2.new(0, 26, 0, 26)
    SuoxiaoBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    SuoxiaoBtn.BorderSizePixel = 0
    SuoxiaoBtn.Text = "-"
    SuoxiaoBtn.TextColor3 = Yanse.GreyLight
    SuoxiaoBtn.Font = Ziti.Bold
    SuoxiaoBtn.TextSize = 12
    SuoxiaoBtn.AutoButtonColor = false
    SuoxiaoBtn.ZIndex = 12
    SuoxiaoBtn.Parent = DongzuoRongna
    chuangjianYuanjiao(SuoxiaoBtn, 13)
    BangdingJiaohuShengyin(SuoxiaoBtn)

    SuoxiaoBtn.MouseEnter:Connect(function()
        DonghuaFuwu:Create(SuoxiaoBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 45, 45), TextColor3 = Yanse.White}):Play()
    end)
    SuoxiaoBtn.MouseLeave:Connect(function()
        DonghuaFuwu:Create(SuoxiaoBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28, 28, 28), TextColor3 = Yanse.GreyLight}):Play()
    end)
end

zhizuoKetuo(BiaotouTiao, ZhuKuangjia)

local SuoxiaoJiaonang = Instance.new("ImageButton")
local SuoxiaoMiaobian
do
    SuoxiaoJiaonang.Name = "MinimizedPill"
    SuoxiaoJiaonang.Size = UDim2.new(0, 56, 0, 56)
    SuoxiaoJiaonang.Position = UDim2.new(0.5, -28, 0.5, -28)
    SuoxiaoJiaonang.BackgroundColor3 = Yanse.DarkMid
    SuoxiaoJiaonang.BorderSizePixel = 0
    SuoxiaoJiaonang.AutoButtonColor = false
    SuoxiaoJiaonang.Visible = false
    SuoxiaoJiaonang.ZIndex = 100
    SuoxiaoJiaonang.Parent = PingmuJiemian
    chuangjianYuanjiao(SuoxiaoJiaonang, 28)
    SuoxiaoMiaobian = chuangjianMiaobian(SuoxiaoJiaonang, Yanse.BrandRed, 2, 0.1)
    BangdingJiaohuShengyin(SuoxiaoJiaonang)
    zhizuoKetuo(SuoxiaoJiaonang, SuoxiaoJiaonang)
    JiazaiTupianYibu(SuoxiaoJiaonang, TUPIAN_URLS.PillLogo)
end

local shiSuoxiao = false
local huancunChuangkouZuobiao = ZhuKuangjia.Position
local huancunJiaonangZuobiao = nil

local function xianzhiWeizhi(pos, size)
    local shikou = Xiangji.ViewportSize

    local w = size.X.Scale * shikou.X + size.X.Offset
    local h = size.Y.Scale * shikou.Y + size.Y.Offset
    local px = pos.X.Scale * shikou.X + pos.X.Offset
    local py = pos.Y.Scale * shikou.Y + pos.Y.Offset
    local x = math.clamp(px, 0, math.max(shikou.X - w, 0))
    local y = math.clamp(py, 0, math.max(shikou.Y - h, 0))
    return UDim2.new(0, x, 0, y)
end

local function shezhiSuoxiao(state)
    shiSuoxiao = state
    if state then
        huancunChuangkouZuobiao = ZhuKuangjia.Position
        if not huancunJiaonangZuobiao then
            local shikou = Xiangji.ViewportSize
            huancunJiaonangZuobiao = UDim2.new(0, 30, 0, shikou.Y / 2 - 28)
        end
        SuoxiaoJiaonang.Position = xianzhiWeizhi(huancunJiaonangZuobiao, SuoxiaoJiaonang.Size)
        ZhuKuangjia.Visible = false
        SuoxiaoJiaonang.Visible = true
        SuoxiaoJiaonang.Size = UDim2.new(0, 0, 0, 0)
        DonghuaFuwu:Create(SuoxiaoJiaonang, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 56, 0, 56)
        }):Play()
    else
        huancunJiaonangZuobiao = SuoxiaoJiaonang.Position
        SuoxiaoJiaonang.Visible = false
        ZhuKuangjia.Position = xianzhiWeizhi(huancunChuangkouZuobiao, ZhuKuangjia.Size)
        ZhuKuangjia.Visible = true
    end
end

local CaidanKuangjia = Instance.new("Frame")
CaidanKuangjia.Name = "MenuFrame"
CaidanKuangjia.Size = UDim2.new(1, 0, 1, -52)
CaidanKuangjia.Position = UDim2.new(0, 0, 0, 52)
CaidanKuangjia.BackgroundTransparency = 1
CaidanKuangjia.Parent = ZhuKuangjia

local DangqianFenlei = "All"
local FenleiBtn = Instance.new("TextButton")
local FenleiXiala = Instance.new("ScrollingFrame")
local SousuoKuang = Instance.new("TextBox")
local BiaozhiGundong = Instance.new("ScrollingFrame")
local HuoyueBiaozhiShaixuan = {}

do
    local ShaixuanPai = Instance.new("Frame")
    ShaixuanPai.Name = "FilterRow"
    ShaixuanPai.Size = UDim2.new(1, -36, 0, 36)
    ShaixuanPai.Position = UDim2.new(0, 18, 0, 12)
    ShaixuanPai.BackgroundTransparency = 1
    ShaixuanPai.ZIndex = 2
    ShaixuanPai.Parent = CaidanKuangjia

    FenleiBtn.Name = "GenreBtn"
    FenleiBtn.Size = UDim2.new(0, 115, 1, 0)
    FenleiBtn.Position = UDim2.new(0, 0, 0, 0)
    FenleiBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    FenleiBtn.Text = "Genre: All "
    FenleiBtn.TextColor3 = Yanse.White
    FenleiBtn.Font = Ziti.Bold
    FenleiBtn.TextSize = 12
    FenleiBtn.AutoButtonColor = false
    FenleiBtn.ZIndex = 3
    FenleiBtn.Parent = ShaixuanPai
    chuangjianYuanjiao(FenleiBtn, 4)
    chuangjianMiaobian(FenleiBtn, Yanse.Border, 1, 0.4)
    BangdingJiaohuShengyin(FenleiBtn)

    FenleiXiala.Name = "GenreDropdown"
    FenleiXiala.Size = UDim2.new(0, 140, 0, 110)
    FenleiXiala.Position = UDim2.new(0, 0, 1, 5)
    FenleiXiala.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    FenleiXiala.ZIndex = 5
    FenleiXiala.Visible = false
    FenleiXiala.ScrollBarThickness = 4
    FenleiXiala.ScrollBarImageColor3 = Yanse.BrandRed
    FenleiXiala.BorderSizePixel = 0
    FenleiXiala.CanvasSize = UDim2.new(0, 0, 0, 0)
    FenleiXiala.Parent = FenleiBtn
    chuangjianYuanjiao(FenleiXiala, 4)
    chuangjianMiaobian(FenleiXiala, Yanse.Border, 1, 0.4)

    local FenleiBuju = Instance.new("UIListLayout")
    FenleiBuju.SortOrder = Enum.SortOrder.LayoutOrder
    FenleiBuju.Parent = FenleiXiala

    FenleiBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        FenleiXiala.CanvasSize = UDim2.new(0, 0, 0, FenleiBuju.AbsoluteContentSize.Y)
    end)

    local FenleiLiebiao = {"All", "My List", "Action", "Comedy", "Horror", "Insta Move", "Hat reanim", "Explicit"}
    for _, genre in ipairs(FenleiLiebiao) do
        local gBtn = Instance.new("TextButton")
        gBtn.Size = UDim2.new(1, -6, 0, 26)
        gBtn.BackgroundTransparency = 1
        gBtn.Text = " " .. genre
        gBtn.TextColor3 = Yanse.GreyLight
        gBtn.Font = Ziti.Medium
        gBtn.TextSize = 12
        gBtn.TextXAlignment = Enum.TextXAlignment.Left
        gBtn.ZIndex = 6
        gBtn.Parent = FenleiXiala
        BangdingJiaohuShengyin(gBtn)
        gBtn.MouseEnter:Connect(function() DonghuaFuwu:Create(gBtn, TweenInfo.new(0.1), {TextColor3 = Yanse.White, BackgroundTransparency = 0.9}):Play() end)
        gBtn.MouseLeave:Connect(function() DonghuaFuwu:Create(gBtn, TweenInfo.new(0.1), {TextColor3 = Yanse.GreyLight, BackgroundTransparency = 1}):Play() end)

        gBtn.MouseButton1Click:Connect(function()
            DangqianFenlei = genre
            FenleiBtn.Text = "Genre: " .. genre .. " "
            FenleiXiala.Visible = false
            if gengxinLunbo then gengxinLunbo() end
        end)
    end

    FenleiBtn.MouseButton1Click:Connect(function() FenleiXiala.Visible = not FenleiXiala.Visible end)

    local SousuoKuangjia = Instance.new("Frame")
    SousuoKuangjia.Name = "SearchFrame"
    SousuoKuangjia.Size = UDim2.new(0, 260, 1, 0)
    SousuoKuangjia.Position = UDim2.new(0, 125, 0, 0)
    SousuoKuangjia.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    SousuoKuangjia.BorderSizePixel = 0
    SousuoKuangjia.ZIndex = 3
    SousuoKuangjia.Parent = ShaixuanPai
    chuangjianYuanjiao(SousuoKuangjia, 4)
    chuangjianMiaobian(SousuoKuangjia, Yanse.Border, 1, 0.4)

    local SousuoTubiao = Instance.new("ImageLabel")
    SousuoTubiao.Name = "SearchIcon"
    SousuoTubiao.Size = UDim2.new(0, 15, 0, 15)
    SousuoTubiao.Position = UDim2.new(0, 10, 0.5, -7)
    SousuoTubiao.BackgroundTransparency = 1
    SousuoTubiao.ZIndex = 4
    SousuoTubiao.Parent = SousuoKuangjia
    JiazaiTupianYibu(SousuoTubiao, "https://raw.githubusercontent.com/Fe-ProjectR/GAME-IMAGES/refs/heads/main/Untitled226_20260710163154.png")

    SousuoKuang.Name = "SearchBox"
    SousuoKuang.Size = UDim2.new(1, -36, 1, 0)
    SousuoKuang.Position = UDim2.new(0, 32, 0, 0)
    SousuoKuang.BackgroundTransparency = 1
    SousuoKuang.BorderSizePixel = 0
    SousuoKuang.Text = ""
    SousuoKuang.TextColor3 = Yanse.White
    SousuoKuang.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
    SousuoKuang.PlaceholderText = "Titles, creators..."
    SousuoKuang.TextSize = 13
    SousuoKuang.Font = Ziti.Book
    SousuoKuang.ClearTextOnFocus = false
    SousuoKuang.TextXAlignment = Enum.TextXAlignment.Left
    SousuoKuang.ZIndex = 4
    SousuoKuang.Parent = SousuoKuangjia

    SousuoKuang.Focused:Connect(function()
        DonghuaFuwu:Create(SousuoKuangjia, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)
    SousuoKuang.FocusLost:Connect(function()
        DonghuaFuwu:Create(SousuoKuangjia, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}):Play()
    end)

    BiaozhiGundong.Name = "TagScroll"
    BiaozhiGundong.Size = UDim2.new(1, -395, 1, 0)
    BiaozhiGundong.Position = UDim2.new(0, 395, 0, 0)
    BiaozhiGundong.BackgroundTransparency = 1
    BiaozhiGundong.ScrollBarThickness = 2
    BiaozhiGundong.ScrollBarImageColor3 = Yanse.GreyMuted
    BiaozhiGundong.CanvasSize = UDim2.new(0, 0, 0, 0)
    BiaozhiGundong.ZIndex = 3
    BiaozhiGundong.Parent = ShaixuanPai

    local BiaozhiBuju = Instance.new("UIListLayout")
    BiaozhiBuju.FillDirection = Enum.FillDirection.Horizontal
    BiaozhiBuju.VerticalAlignment = Enum.VerticalAlignment.Center
    BiaozhiBuju.Padding = UDim.new(0, 8)
    BiaozhiBuju.Parent = BiaozhiGundong

    for _, tagName in ipairs(WeiyiBiaozhi) do
        local count = BiaozhiShuliang[tagName]
        local tBtn = Instance.new("TextButton")
        tBtn.Text = tagName .. " (" .. count .. ")"
        tBtn.Font = Ziti.Bold
        tBtn.TextSize = 11
        tBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        tBtn.TextColor3 = Yanse.GreyLight
        tBtn.ZIndex = 4
        local size = WenbenFuwu:GetTextSize(tBtn.Text, 11, Ziti.Bold, Vector2.new(999, 20))
        tBtn.Size = UDim2.new(0, size.X + 16, 0, 26)

        chuangjianYuanjiao(tBtn, 13)
        local miaobian = chuangjianMiaobian(tBtn, Yanse.Border, 1)
        tBtn.Parent = BiaozhiGundong
        BangdingJiaohuShengyin(tBtn)

        tBtn.MouseButton1Click:Connect(function()
            if HuoyueBiaozhiShaixuan[tagName] then
                HuoyueBiaozhiShaixuan[tagName] = nil
                DonghuaFuwu:Create(tBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 24, 24), TextColor3 = Yanse.GreyLight}):Play()
                miaobian.Color = Yanse.Border
            else
                HuoyueBiaozhiShaixuan[tagName] = true
                DonghuaFuwu:Create(tBtn, TweenInfo.new(0.2), {BackgroundColor3 = Yanse.White, TextColor3 = Color3.fromRGB(0, 0, 0)}):Play()
                miaobian.Color = Yanse.White
            end
            if gengxinLunbo then gengxinLunbo() end
        end)
    end

    BiaozhiBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        BiaozhiGundong.CanvasSize = UDim2.new(0, BiaozhiBuju.AbsoluteContentSize.X + 10, 0, 0)
    end)
end

local LunboRongqi = Instance.new("Frame")
LunboRongqi.Name = "CarouselContainer"
LunboRongqi.Size = UDim2.new(1, -36, 1, -114)
LunboRongqi.Position = UDim2.new(0, 18, 0, 60)
LunboRongqi.BackgroundTransparency = 1
LunboRongqi.ClipsDescendants = true
LunboRongqi.ZIndex = 1
LunboRongqi.Parent = CaidanKuangjia

local function zhizuoJiantou(name, alignRight, symbol)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.AnchorPoint = Vector2.new(alignRight and 1 or 0, 0.5)
    btn.Position = alignRight and UDim2.new(1, -2, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BackgroundTransparency = 0.1
    btn.TextColor3 = Yanse.White
    btn.TextSize = 16
    btn.Font = Ziti.Bold
    btn.Text = symbol
    btn.AutoButtonColor = false
    btn.ZIndex = 8
    btn.Parent = LunboRongqi
    chuangjianYuanjiao(btn, 15)
    chuangjianMiaobian(btn, Color3.fromRGB(60, 60, 60), 1, 0.6)
    BangdingJiaohuShengyin(btn)
    return btn
end

local ZuoJiantou = zhizuoJiantou("LeftArrow", false, "<")
local YouJiantou = zhizuoJiantou("RightArrow", true, ">")

local DianyingLunbo = Instance.new("Frame")
DianyingLunbo.Name = "MovieCarousel"
DianyingLunbo.Size = UDim2.new(1, 0, 1, 0)
DianyingLunbo.BackgroundTransparency = 1
DianyingLunbo.ZIndex = 2
DianyingLunbo.Parent = LunboRongqi

local KongZhuangtai = Instance.new("TextLabel")
KongZhuangtai.Name = "EmptyState"
KongZhuangtai.Size = UDim2.new(1, 0, 1, 0)
KongZhuangtai.BackgroundTransparency = 1
KongZhuangtai.Text = "No matches found."
KongZhuangtai.TextColor3 = Yanse.GreyMuted
KongZhuangtai.Font = Ziti.Book
KongZhuangtai.TextSize = 14
KongZhuangtai.Visible = false
KongZhuangtai.ZIndex = 3
KongZhuangtai.Parent = LunboRongqi

local YuandianRongna = Instance.new("Frame")
YuandianRongna.Name = "DotsHolder"
YuandianRongna.Size = UDim2.new(1, 0, 0, 10)
YuandianRongna.Position = UDim2.new(0, 0, 1, -20)
YuandianRongna.BackgroundTransparency = 1
YuandianRongna.Parent = CaidanKuangjia

local XiangqingKuangjia = Instance.new("Frame")
local XiangqingTupian = Instance.new("ImageLabel")
local XiangqingBiaoti = Instance.new("TextLabel")
local YuanxinxiPai = Instance.new("TextLabel")
local BiaozhiXiangqingGundong = Instance.new("ScrollingFrame")
local XiangqingBiaozhiBuju = Instance.new("UIListLayout")
local XiangqingMiaoshu = Instance.new("TextLabel")
local FudongXuanxiangPai = Instance.new("Frame")
local YincangTexiaoXuanxiangBtn = Instance.new("TextButton")
local JingyinYinyueXuanxiangBtn = Instance.new("TextButton")
local BofangBtn = Instance.new("TextButton")
local ShoucangBtn = Instance.new("TextButton")
local FanhuiBtn = Instance.new("TextButton")

do
    XiangqingKuangjia.Name = "DetailFrame"
    XiangqingKuangjia.Size = UDim2.new(1, 0, 1, -52)
    XiangqingKuangjia.Position = UDim2.new(0, 0, 0, 52)
    XiangqingKuangjia.BackgroundTransparency = 1
    XiangqingKuangjia.Visible = false
    XiangqingKuangjia.Parent = ZhuKuangjia

    local XiangqingZhengwen = Instance.new("Frame")
    XiangqingZhengwen.Name = "DetailBody"
    XiangqingZhengwen.Size = UDim2.new(1, -36, 1, -24)
    XiangqingZhengwen.Position = UDim2.new(0, 18, 0, 12)
    XiangqingZhengwen.BackgroundTransparency = 1
    XiangqingZhengwen.Parent = XiangqingKuangjia

    XiangqingTupian.Name = "DetailImage"
    XiangqingTupian.Size = UDim2.new(0.38, 0, 1, 0)
    XiangqingTupian.BackgroundColor3 = Yanse.DarkCard
    XiangqingTupian.ScaleType = Enum.ScaleType.Crop
    XiangqingTupian.Parent = XiangqingZhengwen
    chuangjianYuanjiao(XiangqingTupian, 6)

    local XiangqingTupianGuangyun = Instance.new("ImageLabel")
    XiangqingTupianGuangyun.Size = UDim2.new(1, 20, 1, 20)
    XiangqingTupianGuangyun.Position = UDim2.new(0, -10, 0, -10)
    XiangqingTupianGuangyun.BackgroundTransparency = 1
    XiangqingTupianGuangyun.Image = "rbxassetid://6014261993"
    XiangqingTupianGuangyun.ImageColor3 = Color3.new(0,0,0)
    XiangqingTupianGuangyun.ImageTransparency = 0.5
    XiangqingTupianGuangyun.ScaleType = Enum.ScaleType.Slice
    XiangqingTupianGuangyun.SliceCenter = Rect.new(49, 49, 450, 450)
    XiangqingTupianGuangyun.ZIndex = 0
    XiangqingTupianGuangyun.Parent = XiangqingTupian

    local XinxiMianban = Instance.new("Frame")
    XinxiMianban.Name = "InfoPanel"
    XinxiMianban.Size = UDim2.new(0.58, 0, 1, 0)
    XinxiMianban.Position = UDim2.new(0.42, 0, 0, 0)
    XinxiMianban.BackgroundTransparency = 1
    XinxiMianban.Parent = XiangqingZhengwen

    XiangqingBiaoti.Name = "DetailTitle"
    XiangqingBiaoti.Size = UDim2.new(1, 0, 0, 36)
    XiangqingBiaoti.BackgroundTransparency = 1
    XiangqingBiaoti.TextColor3 = Yanse.White
    XiangqingBiaoti.TextSize = 24
    XiangqingBiaoti.Font = Ziti.Heavy
    XiangqingBiaoti.TextXAlignment = Enum.TextXAlignment.Left
    XiangqingBiaoti.TextTruncate = Enum.TextTruncate.AtEnd
    XiangqingBiaoti.Parent = XinxiMianban

    YuanxinxiPai.Name = "MetaRow"
    YuanxinxiPai.Size = UDim2.new(1, 0, 0, 16)
    YuanxinxiPai.Position = UDim2.new(0, 0, 0, 40)
    YuanxinxiPai.BackgroundTransparency = 1
    YuanxinxiPai.TextColor3 = Yanse.GreyMuted
    YuanxinxiPai.TextSize = 12
    YuanxinxiPai.Font = Ziti.Medium
    YuanxinxiPai.TextXAlignment = Enum.TextXAlignment.Left
    YuanxinxiPai.Parent = XinxiMianban

    BiaozhiXiangqingGundong.Name = "TagsDetailScroll"
    BiaozhiXiangqingGundong.Size = UDim2.new(1, 0, 0, 30)
    BiaozhiXiangqingGundong.Position = UDim2.new(0, 0, 0, 60)
    BiaozhiXiangqingGundong.BackgroundTransparency = 1
    BiaozhiXiangqingGundong.ScrollBarThickness = 0
    BiaozhiXiangqingGundong.Parent = XinxiMianban

    XiangqingBiaozhiBuju.FillDirection = Enum.FillDirection.Horizontal
    XiangqingBiaozhiBuju.VerticalAlignment = Enum.VerticalAlignment.Center
    XiangqingBiaozhiBuju.Padding = UDim.new(0, 8)
    XiangqingBiaozhiBuju.Parent = BiaozhiXiangqingGundong

    XiangqingMiaoshu.Name = "DetailDescription"
    XiangqingMiaoshu.Size = UDim2.new(1, 0, 1, -170)
    XiangqingMiaoshu.Position = UDim2.new(0, 0, 0, 95)
    XiangqingMiaoshu.BackgroundTransparency = 1
    XiangqingMiaoshu.TextColor3 = Yanse.GreyLight
    XiangqingMiaoshu.TextSize = 12
    XiangqingMiaoshu.Font = Ziti.Book
    XiangqingMiaoshu.TextXAlignment = Enum.TextXAlignment.Left
    XiangqingMiaoshu.TextYAlignment = Enum.TextYAlignment.Top
    XiangqingMiaoshu.TextWrapped = true
    XiangqingMiaoshu.Parent = XinxiMianban

    FudongXuanxiangPai.Name = "ReanimOptionsRow"
    FudongXuanxiangPai.Size = UDim2.new(1, 0, 0, 34)
    FudongXuanxiangPai.Position = UDim2.new(0, 0, 1, -105)
    FudongXuanxiangPai.BackgroundTransparency = 1
    FudongXuanxiangPai.Visible = false
    FudongXuanxiangPai.Parent = XinxiMianban

    local FudongXuanxiangBuju = Instance.new("UIListLayout")
    FudongXuanxiangBuju.FillDirection = Enum.FillDirection.Horizontal
    FudongXuanxiangBuju.HorizontalAlignment = Enum.HorizontalAlignment.Left
    FudongXuanxiangBuju.VerticalAlignment = Enum.VerticalAlignment.Center
    FudongXuanxiangBuju.Padding = UDim.new(0, 8)
    FudongXuanxiangBuju.SortOrder = Enum.SortOrder.LayoutOrder
    FudongXuanxiangBuju.Parent = FudongXuanxiangPai

    local function anzhuangFudongXuanxiangAnniu(button, name, order)
        button.Name = name
        button.Size = UDim2.new(0.5, -4, 1, 0)
        button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        button.BorderSizePixel = 0
        button.Text = name
        button.TextColor3 = Yanse.White
        button.Font = Ziti.Bold
        button.TextSize = 11
        button.AutoButtonColor = false
        button.LayoutOrder = order
        button.Visible = false
        button.Parent = FudongXuanxiangPai
        chuangjianYuanjiao(button, 4)
        chuangjianMiaobian(button, Yanse.Border, 1)
        BangdingJiaohuShengyin(button)
    end

    anzhuangFudongXuanxiangAnniu(YincangTexiaoXuanxiangBtn, "HideEffectsOptionBtn", 1)
    anzhuangFudongXuanxiangAnniu(JingyinYinyueXuanxiangBtn, "MuteMusicOptionBtn", 2)

    local AnniuPai = Instance.new("Frame")
    AnniuPai.Name = "ButtonRow"
    AnniuPai.Size = UDim2.new(1, 0, 0, 48)
    AnniuPai.Position = UDim2.new(0, 0, 1, -62)
    AnniuPai.BackgroundTransparency = 1
    AnniuPai.Parent = XinxiMianban

    local AnniuBuju = Instance.new("UIListLayout")
    AnniuBuju.FillDirection = Enum.FillDirection.Horizontal
    AnniuBuju.Padding = UDim.new(0, 12)
    AnniuBuju.Parent = AnniuPai

    BofangBtn.Name = "PlayBtn"
    BofangBtn.Size = UDim2.new(0.35, -6, 1, 0)
    BofangBtn.BackgroundColor3 = Yanse.BrandRed
    BofangBtn.Text = "Execute"
    BofangBtn.Font = Ziti.Bold
    BofangBtn.TextSize = 13
    BofangBtn.TextColor3 = Yanse.White
    BofangBtn.AutoButtonColor = false
    BofangBtn.Parent = AnniuPai
    chuangjianYuanjiao(BofangBtn, 4)
    BangdingJiaohuShengyin(BofangBtn)

    ShoucangBtn.Name = "FavBtn"
    ShoucangBtn.Size = UDim2.new(0.3, -6, 1, 0)
    ShoucangBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ShoucangBtn.Text = "+ My List"
    ShoucangBtn.Font = Ziti.Bold
    ShoucangBtn.TextSize = 11
    ShoucangBtn.TextColor3 = Yanse.White
    ShoucangBtn.AutoButtonColor = false
    ShoucangBtn.Parent = AnniuPai
    chuangjianYuanjiao(ShoucangBtn, 4)
    chuangjianMiaobian(ShoucangBtn, Yanse.Border, 1)
    BangdingJiaohuShengyin(ShoucangBtn)

    FanhuiBtn.Name = "BackBtn"
    FanhuiBtn.Size = UDim2.new(0.25, -6, 1, 0)
    FanhuiBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    FanhuiBtn.Text = "Back"
    FanhuiBtn.Font = Ziti.Bold
    FanhuiBtn.TextSize = 12
    FanhuiBtn.TextColor3 = Yanse.White
    FanhuiBtn.AutoButtonColor = false
    FanhuiBtn.Parent = AnniuPai
    chuangjianYuanjiao(FanhuiBtn, 4)
    BangdingJiaohuShengyin(FanhuiBtn)

end

local luyouDaoShitu

local ZhixingqiKuangjia = Instance.new("Frame")
local DaimaShuru = Instance.new("TextBox")
local ZhixingDongzuoBtn = Instance.new("TextButton")
local ZhixingQingkongBtn = Instance.new("TextButton")

-- 导演剪辑 多标签脚本编辑器 自动保存
local DaoyanZhuangtai = {
    File = "AN/NFX_DirectorTabs.json",
    Tabs = {},
    Active = 1,
    Token = 0,
    Buttons = {},
    Scroller = nil,
    RenameBox = nil,
    Status = nil,
    NewButton = nil
}

;(function()
    local UI = {}
    DaoyanZhuangtai.UI = UI
    DaoyanZhuangtai.Seen = setmetatable({}, {__mode = "k"})
    DaoyanZhuangtai.PrevActive = nil

    function UI.Tween(obj, t, props, style, dir)
        local tw = DonghuaFuwu:Create(obj, TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
        tw:Play()
        return tw
    end

    local function xinBujian(parent, reg, color, x, y, w, h, rot, round)
        local f = Instance.new("Frame")
        f.AnchorPoint = Vector2.new(0.5, 0.5)
        f.Position = UDim2.new(x + w / 2, 0, y + h / 2, 0)
        f.Size = UDim2.new(w, 0, h, 0)
        f.BackgroundColor3 = color
        f.BorderSizePixel = 0
        f.Rotation = rot or 0
        f.Parent = parent
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(round or 0.5, 0)
        c.Parent = f
        reg[#reg + 1] = {f, "BackgroundColor3"}
        return f
    end

    local function xinLunkuo(parent, reg, color, px, x, y, w, h)
        local f = Instance.new("Frame")
        f.Position = UDim2.new(x, 0, y, 0)
        f.Size = UDim2.new(w, 0, h, 0)
        f.BackgroundTransparency = 1
        f.BorderSizePixel = 0
        f.Parent = parent
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0.2, 0)
        c.Parent = f
        local s = Instance.new("UIStroke")
        s.Color = color
        s.Thickness = math.max(1, px * 0.085)
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        s.Parent = f
        reg[#reg + 1] = {s, "Color"}
        return f
    end

    local gouzaoqi = {}

    gouzaoqi.plus = function(p, reg, col)
        xinBujian(p, reg, col, 0.18, 0.43, 0.64, 0.14)
        xinBujian(p, reg, col, 0.43, 0.18, 0.14, 0.64)
    end

    gouzaoqi.x = function(p, reg, col)
        xinBujian(p, reg, col, 0.10, 0.43, 0.80, 0.14, 45)
        xinBujian(p, reg, col, 0.10, 0.43, 0.80, 0.14, -45)
    end

    gouzaoqi.check = function(p, reg, col)
        xinBujian(p, reg, col, 0.19, 0.50, 0.32, 0.15, 45)
        xinBujian(p, reg, col, 0.30, 0.39, 0.60, 0.15, -45)
    end

    gouzaoqi.play = function(p, reg, col)
        local clip = Instance.new("Frame")
        clip.BackgroundTransparency = 1
        clip.BorderSizePixel = 0
        clip.ClipsDescendants = true
        clip.Position = UDim2.new(0.30, 0, 0.10, 0)
        clip.Size = UDim2.new(0.42, 0, 0.80, 0)
        clip.Parent = p
        local d = Instance.new("Frame")
        d.AnchorPoint = Vector2.new(0.5, 0.5)
        d.Position = UDim2.new(0, 0, 0.5, 0)
        d.Size = UDim2.new(1.347, 0, 0.7071, 0)
        d.Rotation = 45
        d.BackgroundColor3 = col
        d.BorderSizePixel = 0
        d.Parent = clip
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0.12, 0)
        c.Parent = d
        reg[#reg + 1] = {d, "BackgroundColor3"}
    end

    gouzaoqi.trash = function(p, reg, col, px)
        xinBujian(p, reg, col, 0.16, 0.22, 0.68, 0.10)
        xinBujian(p, reg, col, 0.38, 0.10, 0.24, 0.09)
        xinLunkuo(p, reg, col, px, 0.26, 0.36, 0.48, 0.50)
        xinBujian(p, reg, col, 0.41, 0.50, 0.07, 0.24)
        xinBujian(p, reg, col, 0.54, 0.50, 0.07, 0.24)
    end

    gouzaoqi.copy = function(p, reg, col, px)
        xinBujian(p, reg, col, 0.12, 0.12, 0.40, 0.10)
        xinBujian(p, reg, col, 0.12, 0.12, 0.10, 0.40)
        xinLunkuo(p, reg, col, px, 0.36, 0.36, 0.52, 0.52)
    end

    gouzaoqi.lines = function(p, reg, col)
        xinBujian(p, reg, col, 0.14, 0.20, 0.72, 0.10)
        xinBujian(p, reg, col, 0.14, 0.45, 0.52, 0.10)
        xinBujian(p, reg, col, 0.14, 0.70, 0.36, 0.10)
    end

    gouzaoqi.doc = function(p, reg, col, px)
        xinLunkuo(p, reg, col, px, 0.22, 0.08, 0.56, 0.84)
        xinBujian(p, reg, col, 0.34, 0.32, 0.32, 0.08)
        xinBujian(p, reg, col, 0.34, 0.50, 0.32, 0.08)
        xinBujian(p, reg, col, 0.34, 0.68, 0.20, 0.08)
    end

    gouzaoqi.pencil = function(p, reg, col)
        xinBujian(p, reg, col, 0.24, 0.38, 0.62, 0.20, -45)
        xinBujian(p, reg, col, 0.14, 0.82, 0.44, 0.08)
    end

    gouzaoqi.kw = function(p, reg, col)
        xinBujian(p, reg, col, 0.10, 0.18, 0.26, 0.14, 0, 0.3)
        xinBujian(p, reg, col, 0.46, 0.18, 0.44, 0.14, 0, 0.3)
        xinBujian(p, reg, col, 0.10, 0.43, 0.80, 0.14, 0, 0.3)
        xinBujian(p, reg, col, 0.10, 0.68, 0.56, 0.14, 0, 0.3)
    end

    gouzaoqi.node = function(p, reg, col)
        xinBujian(p, reg, col, 0.18, 0.24, 0.10, 0.52)
        xinBujian(p, reg, col, 0.20, 0.45, 0.46, 0.10)
        xinBujian(p, reg, col, 0.06, 0.06, 0.34, 0.34)
        xinBujian(p, reg, col, 0.06, 0.60, 0.34, 0.34)
        xinBujian(p, reg, col, 0.58, 0.33, 0.34, 0.34)
    end

    gouzaoqi.field = function(p, reg, col, px)
        xinLunkuo(p, reg, col, px, 0.10, 0.10, 0.80, 0.80)
        xinBujian(p, reg, col, 0.36, 0.36, 0.28, 0.28)
    end

    gouzaoqi.cube = function(p, reg, col, px)
        local o = xinLunkuo(p, reg, col, px, 0.20, 0.20, 0.60, 0.60)
        o.Rotation = 45
        xinBujian(p, reg, col, 0.40, 0.40, 0.20, 0.20)
    end

    function UI.Icon(kind, parent, color, px)
        local root = Instance.new("Frame")
        root.Name = "Icon_" .. kind
        root.AnchorPoint = Vector2.new(0.5, 0.5)
        root.Size = UDim2.new(0, px, 0, px)
        root.Position = UDim2.new(0.5, 0, 0.5, 0)
        root.BackgroundTransparency = 1
        root.BorderSizePixel = 0
        root.ZIndex = 5
        root.Parent = parent
        local reg = {}
        local gouzao = gouzaoqi[kind]
        if gouzao then gouzao(root, reg, color, px) end
        local icon = {Root = root}
        function icon.Paint(c, t)
            for _, r in ipairs(reg) do
                if t and t > 0 then
                    UI.Tween(r[1], t, {[r[2]] = c})
                else
                    r[1][r[2]] = c
                end
            end
        end
        return icon
    end

    function UI.Ripple(btn)
        if not (btn and btn.Parent) then return end
        btn.ClipsDescendants = true
        local d = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 1.7
        local r = Instance.new("Frame")
        r.AnchorPoint = Vector2.new(0.5, 0.5)
        r.Position = UDim2.new(0.5, 0, 0.5, 0)
        r.Size = UDim2.new(0, 0, 0, 0)
        r.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        r.BackgroundTransparency = 0.8
        r.BorderSizePixel = 0
        r.ZIndex = 2
        r.Parent = btn
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0.5, 0)
        c.Parent = r
        UI.Tween(r, 0.45, {Size = UDim2.new(0, d, 0, d), BackgroundTransparency = 1})
        task.delay(0.5, function()
            if r then r:Destroy() end
        end)
    end
end)()

function quebaoDaoyanWenjianjia()
    pcall(function()
        if makefolder and isfolder and not isfolder("AN") then
            makefolder("AN")
        end
    end)
end

quebaoDaoyanWenjianjia()

function anquanXiangkaMingzi(name)
    name = tostring(name or ""):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    name = name:gsub("[\\/:*?\"<>|]", "")
    if name == "" then name = "Script" end
    return name:sub(1, 48)
end

function zhizuoWeiyiDaoyanMingzi(name, ignoreIndex)
    local base = anquanXiangkaMingzi(name)
    local houxuan = base
    local suffix = 2
    while true do
        local beizhan = false
        for i, tab in ipairs(DaoyanZhuangtai.Tabs) do
            if i ~= ignoreIndex and tostring(tab.Name or ""):lower() == houxuan:lower() then
                beizhan = true
                break
            end
        end
        if not beizhan then return houxuan end
        houxuan = base .. " (" .. suffix .. ")"
        suffix = suffix + 1
    end
end

function baocunDaoyanXiangka()
    DaoyanZhuangtai.Token = DaoyanZhuangtai.Token + 1
    pcall(function()
        if writefile then
            writefile(DaoyanZhuangtai.File, HttpFuwu:JSONEncode(DaoyanZhuangtai.Tabs))
        end
    end)
end

function jiazaiDaoyanXiangka()
    DaoyanZhuangtai.Tabs = {}
    pcall(function()
        if isfile and readfile and isfile(DaoyanZhuangtai.File) then
            local decoded = HttpFuwu:JSONDecode(readfile(DaoyanZhuangtai.File))
            if type(decoded) == "table" then
                for _, tab in ipairs(decoded) do
                    if type(tab) == "table" then
                        local name = anquanXiangkaMingzi(tab.Name or tab.Title or "Script")
                        local laiyuan = type(tab.Script) == "string" and tab.Script or ""
                        table.insert(DaoyanZhuangtai.Tabs, {Name = name, Script = laiyuan})
                    end
                end
            end
        end
    end)
    if #DaoyanZhuangtai.Tabs == 0 then
        DaoyanZhuangtai.Tabs = {{Name = "Script 1", Script = ""}}
        baocunDaoyanXiangka()
    end
    DaoyanZhuangtai.Active = math.clamp(DaoyanZhuangtai.Active, 1, #DaoyanZhuangtai.Tabs)
end

jiazaiDaoyanXiangka()

function dangqianDaoyanXiangka()
    return DaoyanZhuangtai.Tabs[DaoyanZhuangtai.Active]
end

function baocunHuoyueDaoyanXiangka()
    local tab = dangqianDaoyanXiangka()
    if tab and DaimaShuru then
        tab.Script = DaimaShuru.Text
        baocunDaoyanXiangka()
    end
end

function duilieDaoyanZidongcun()
    DaoyanZhuangtai.Token = DaoyanZhuangtai.Token + 1
    local token = DaoyanZhuangtai.Token
    task.delay(0.35, function()
        if token == DaoyanZhuangtai.Token then
            baocunHuoyueDaoyanXiangka()
            if DaoyanZhuangtai.Status then
                DaoyanZhuangtai.Status.Text = "Saved"
                task.delay(0.8, function()
                    if DaoyanZhuangtai.Status then DaoyanZhuangtai.Status.Text = "Ready · auto-save on" end
                end)
            end
        end
    end)
end

function shuaxinDaoyanXiangkaAnniu()
    if not DaoyanZhuangtai.Scroller then return end
    local UI = DaoyanZhuangtai.UI
    for _, child in ipairs(DaoyanZhuangtai.Scroller:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then
            child:Destroy()
        end
    end
    DaoyanZhuangtai.Buttons = {}

    local huoyueXiangka = dangqianDaoyanXiangka()
    local xiangkaKuandu = shiShouji2() and 122 or 150
    local nengGuanbi = #DaoyanZhuangtai.Tabs > 1
    local huoyueRongna = nil

    for suoyin, tab in ipairs(DaoyanZhuangtai.Tabs) do
        local shiHuoyue = (suoyin == DaoyanZhuangtai.Active)

        local holder = Instance.new("Frame")
        holder.Name = "DirectorTab_" .. suoyin
        holder.LayoutOrder = suoyin
        holder.Size = UDim2.new(0, xiangkaKuandu, 0, 30)
        holder.BackgroundColor3 = shiHuoyue and Color3.fromRGB(32, 32, 32) or Color3.fromRGB(20, 20, 20)
        holder.BorderSizePixel = 0
        holder.ClipsDescendants = true
        holder.Parent = DaoyanZhuangtai.Scroller
        chuangjianYuanjiao(holder, 6)
        chuangjianMiaobian(holder, shiHuoyue and Color3.fromRGB(70, 70, 70) or Yanse.Border, 1, shiHuoyue and 0.2 or 0.55)
        if shiHuoyue then huoyueRongna = holder end

        local qiangdiao = Instance.new("Frame")
        qiangdiao.Name = "Accent"
        qiangdiao.AnchorPoint = Vector2.new(0.5, 0)
        qiangdiao.Position = UDim2.new(0.5, 0, 0, 0)
        qiangdiao.Size = UDim2.new(shiHuoyue and 1 or 0, 0, 0, 2)
        qiangdiao.BackgroundColor3 = Yanse.BrandRed
        qiangdiao.BorderSizePixel = 0
        qiangdiao.ZIndex = 3
        qiangdiao.Parent = holder
        if shiHuoyue and DaoyanZhuangtai.PrevActive ~= tab then
            qiangdiao.Size = UDim2.new(0, 0, 0, 2)
            UI.Tween(qiangdiao, 0.32, {Size = UDim2.new(1, 0, 0, 2)}, Enum.EasingStyle.Cubic)
        end

        local icon = UI.Icon("doc", holder, shiHuoyue and Yanse.White or Yanse.GreyMuted, 13)
        icon.Root.AnchorPoint = Vector2.new(0, 0.5)
        icon.Root.Position = UDim2.new(0, 10, 0.5, 1)

        local xuanzeBtn = Instance.new("TextButton")
        xuanzeBtn.Name = "Select"
        xuanzeBtn.Size = UDim2.new(1, nengGuanbi and -58 or -34, 1, 0)
        xuanzeBtn.Position = UDim2.new(0, 30, 0, 1)
        xuanzeBtn.BackgroundTransparency = 1
        xuanzeBtn.Text = tostring(tab.Name or ("Script " .. suoyin))
        xuanzeBtn.TextColor3 = shiHuoyue and Yanse.White or Yanse.GreyLight
        xuanzeBtn.Font = Ziti.Bold
        xuanzeBtn.TextSize = 11
        xuanzeBtn.TextXAlignment = Enum.TextXAlignment.Left
        xuanzeBtn.TextTruncate = Enum.TextTruncate.AtEnd
        xuanzeBtn.AutoButtonColor = false
        xuanzeBtn.ZIndex = 4
        xuanzeBtn.Parent = holder
        BangdingJiaohuShengyin(xuanzeBtn)

        local guanbiBtn = Instance.new("TextButton")
        guanbiBtn.Name = "Close"
        guanbiBtn.AnchorPoint = Vector2.new(1, 0.5)
        guanbiBtn.Position = UDim2.new(1, -5, 0.5, 1)
        guanbiBtn.Size = UDim2.new(0, 22, 0, 22)
        guanbiBtn.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
        guanbiBtn.BackgroundTransparency = 1
        guanbiBtn.Text = ""
        guanbiBtn.AutoButtonColor = false
        guanbiBtn.Visible = nengGuanbi
        guanbiBtn.ZIndex = 4
        guanbiBtn.Parent = holder
        chuangjianYuanjiao(guanbiBtn, 5)
        local xTubiao = UI.Icon("x", guanbiBtn, Yanse.GreyMuted, 9)
        BangdingJiaohuShengyin(guanbiBtn)

        guanbiBtn.MouseEnter:Connect(function()
            UI.Tween(guanbiBtn, 0.12, {BackgroundTransparency = 0.2})
            xTubiao.Paint(Yanse.White, 0.12)
        end)
        guanbiBtn.MouseLeave:Connect(function()
            UI.Tween(guanbiBtn, 0.12, {BackgroundTransparency = 1})
            xTubiao.Paint(Yanse.GreyMuted, 0.12)
        end)

        xuanzeBtn.MouseEnter:Connect(function()
            if not shiHuoyue then
                UI.Tween(holder, 0.12, {BackgroundColor3 = Color3.fromRGB(28, 28, 28)})
                icon.Paint(Yanse.GreyLight, 0.12)
            end
        end)
        xuanzeBtn.MouseLeave:Connect(function()
            if not shiHuoyue then
                UI.Tween(holder, 0.12, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)})
                icon.Paint(Yanse.GreyMuted, 0.12)
            end
        end)

        xuanzeBtn.MouseButton1Click:Connect(function()
            if suoyin == DaoyanZhuangtai.Active then return end
            baocunHuoyueDaoyanXiangka()
            DaoyanZhuangtai.Active = suoyin
            local xiayiXiangka = dangqianDaoyanXiangka()
            DaimaShuru.Text = xiayiXiangka and xiayiXiangka.Script or ""
            DaoyanZhuangtai.RenameBox.Text = xiayiXiangka and xiayiXiangka.Name or "Script"
            shuaxinDaoyanXiangkaAnniu()
            if DaoyanZhuangtai.Status then DaoyanZhuangtai.Status.Text = "Switched · Auto-save ready" end
        end)

        guanbiBtn.MouseButton1Click:Connect(function()
            if #DaoyanZhuangtai.Tabs <= 1 then return end
            if suoyin == DaoyanZhuangtai.Active then baocunHuoyueDaoyanXiangka() end
            table.remove(DaoyanZhuangtai.Tabs, suoyin)
            if suoyin == DaoyanZhuangtai.Active then
                DaoyanZhuangtai.Active = math.clamp(suoyin, 1, #DaoyanZhuangtai.Tabs)
            elseif suoyin < DaoyanZhuangtai.Active then
                DaoyanZhuangtai.Active = DaoyanZhuangtai.Active - 1
            end
            local xiayiXiangka = dangqianDaoyanXiangka()
            DaimaShuru.Text = xiayiXiangka and xiayiXiangka.Script or ""
            DaoyanZhuangtai.RenameBox.Text = xiayiXiangka and xiayiXiangka.Name or "Script"
            baocunDaoyanXiangka()
            shuaxinDaoyanXiangkaAnniu()
        end)

        if not DaoyanZhuangtai.Seen[tab] then
            DaoyanZhuangtai.Seen[tab] = true
            local pop = Instance.new("UIScale")
            pop.Scale = 0.8
            pop.Parent = holder
            UI.Tween(pop, 0.28, {Scale = 1}, Enum.EasingStyle.Back)
        end

        DaoyanZhuangtai.Buttons[suoyin] = holder
    end

    DaoyanZhuangtai.PrevActive = huoyueXiangka

    if huoyueRongna then
        task.delay(0.06, function()
            local sc = DaoyanZhuangtai.Scroller
            if not (sc and sc.Parent and huoyueRongna.Parent) then return end
            local cp = sc.CanvasPosition.X
            local left = huoyueRongna.AbsolutePosition.X - sc.AbsolutePosition.X + cp
            local you = left + xiangkaKuandu
            local win = sc.AbsoluteSize.X
            local mubiao = cp
            if left < cp then
                mubiao = left - 6
            elseif you > cp + win then
                mubiao = you - win + 6
            end
            if mubiao ~= cp then
                UI.Tween(sc, 0.25, {CanvasPosition = Vector2.new(math.max(mubiao, 0), 0)}, Enum.EasingStyle.Cubic)
            end
        end)
    end
end

function chuangjianDaoyanXiangka(name, laiyuan)
    baocunHuoyueDaoyanXiangka()
    local xinMingzi = zhizuoWeiyiDaoyanMingzi(name or ("Script " .. (#DaoyanZhuangtai.Tabs + 1)))
    table.insert(DaoyanZhuangtai.Tabs, {Name = xinMingzi, Script = type(laiyuan) == "string" and laiyuan or ""})
    DaoyanZhuangtai.Active = #DaoyanZhuangtai.Tabs
    DaimaShuru.Text = DaoyanZhuangtai.Tabs[DaoyanZhuangtai.Active].Script
    if DaoyanZhuangtai.RenameBox then DaoyanZhuangtai.RenameBox.Text = xinMingzi end
    baocunDaoyanXiangka()
    shuaxinDaoyanXiangkaAnniu()
    return DaoyanZhuangtai.Tabs[DaoyanZhuangtai.Active]
end

function chongmingHuoyueDaoyanXiangka(name)
    local tab = dangqianDaoyanXiangka()
    if not tab then return end
    local weiyi = zhizuoWeiyiDaoyanMingzi(name, DaoyanZhuangtai.Active)
    tab.Name = weiyi
    if DaoyanZhuangtai.RenameBox then DaoyanZhuangtai.RenameBox.Text = weiyi end
    baocunDaoyanXiangka()
    shuaxinDaoyanXiangkaAnniu()
end

function dakaiJiaobenZaiDaoyanXiangka(name, laiyuan)
    if type(laiyuan) ~= "string" or laiyuan == "" then return false end
    chuangjianDaoyanXiangka(name, laiyuan)
    luyouDaoShitu("executor")
    gengxinXiangkaHang(ZhixingqiXiangka)
    return true
end

;(function()
    local UI = DaoyanZhuangtai.UI
    local Tween = UI.Tween
    local shiShouji = shiShouji2()

    local C = {
        Shell = Color3.fromRGB(13, 13, 13),
        Field = Color3.fromRGB(20, 20, 20),
        Panel = Color3.fromRGB(35, 35, 35),
        PanelHover = Color3.fromRGB(55, 55, 55),
        PanelOn = Color3.fromRGB(52, 52, 52),
        Ink = Color3.fromRGB(229, 229, 229),
        Gutter = Color3.fromRGB(92, 92, 92),
        Idle = Color3.fromRGB(110, 110, 110),
        Ok = Color3.fromRGB(46, 125, 50),
        Bad = Color3.fromRGB(198, 40, 40),
        BadText = Color3.fromRGB(235, 130, 130)
    }

    local BIANJU_X, PAD_TOP = 10, 8

    ZhixingqiKuangjia.Name = "ExecutorFrame"
    ZhixingqiKuangjia.Size = UDim2.new(1, 0, 1, -52)
    ZhixingqiKuangjia.Position = UDim2.new(0, 0, 0, 52)
    ZhixingqiKuangjia.BackgroundTransparency = 1
    ZhixingqiKuangjia.Visible = false
    ZhixingqiKuangjia.Parent = ZhuKuangjia

    local ZhixingZhengwen = Instance.new("Frame")
    ZhixingZhengwen.Name = "ExecBody"
    ZhixingZhengwen.Size = UDim2.new(1, -36, 1, -24)
    ZhixingZhengwen.Position = UDim2.new(0, 18, 0, 12)
    ZhixingZhengwen.BackgroundTransparency = 1
    ZhixingZhengwen.Parent = ZhixingqiKuangjia

    for _, tab in ipairs(DaoyanZhuangtai.Tabs) do DaoyanZhuangtai.Seen[tab] = true end

    local XiangkaGongjulan = Instance.new("Frame")
    XiangkaGongjulan.Name = "TabToolbar"
    XiangkaGongjulan.Size = UDim2.new(1, 0, 0, 34)
    XiangkaGongjulan.BackgroundTransparency = 1
    XiangkaGongjulan.Parent = ZhixingZhengwen

    local Scroller = Instance.new("ScrollingFrame")
    DaoyanZhuangtai.Scroller = Scroller
    Scroller.Name = "DirectorTabScroller"
    Scroller.Size = UDim2.new(1, -44, 1, 0)
    Scroller.BackgroundTransparency = 1
    Scroller.BorderSizePixel = 0
    Scroller.ScrollBarThickness = 0
    Scroller.ScrollingDirection = Enum.ScrollingDirection.X
    Scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroller.Parent = XiangkaGongjulan

    local XiangkaBuju = Instance.new("UIListLayout")
    XiangkaBuju.FillDirection = Enum.FillDirection.Horizontal
    XiangkaBuju.VerticalAlignment = Enum.VerticalAlignment.Center
    XiangkaBuju.SortOrder = Enum.SortOrder.LayoutOrder
    XiangkaBuju.Padding = UDim.new(0, 6)
    XiangkaBuju.Parent = Scroller
    XiangkaBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroller.CanvasSize = UDim2.new(0, XiangkaBuju.AbsoluteContentSize.X + 8, 0, 0)
    end)

    Scroller.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseWheel then
            local x = math.max(Scroller.CanvasPosition.X - input.Position.Z * 48, 0)
            Tween(Scroller, 0.12, {CanvasPosition = Vector2.new(x, 0)})
        end
    end)

    local XinBtn = Instance.new("TextButton")
    DaoyanZhuangtai.NewButton = XinBtn
    XinBtn.Name = "NewTabButton"
    XinBtn.AnchorPoint = Vector2.new(1, 0.5)
    XinBtn.Position = UDim2.new(1, 0, 0.5, 0)
    XinBtn.Size = UDim2.new(0, 34, 0, 30)
    XinBtn.BackgroundColor3 = Yanse.BrandRed
    XinBtn.Text = ""
    XinBtn.AutoButtonColor = false
    XinBtn.ClipsDescendants = true
    XinBtn.Parent = XiangkaGongjulan
    chuangjianYuanjiao(XinBtn, 6)
    BangdingJiaohuShengyin(XinBtn)
    local jiaTubiao = UI.Icon("plus", XinBtn, Yanse.White, 14)
    XinBtn.MouseEnter:Connect(function() Tween(jiaTubiao.Root, 0.25, {Rotation = 90}, Enum.EasingStyle.Cubic) end)
    XinBtn.MouseLeave:Connect(function() Tween(jiaTubiao.Root, 0.25, {Rotation = 0}, Enum.EasingStyle.Cubic) end)
    XinBtn.MouseButton1Down:Connect(function() UI.Ripple(XinBtn) end)
    XinBtn.MouseButton1Click:Connect(function() chuangjianDaoyanXiangka() end)

    local MingziPai = Instance.new("Frame")
    MingziPai.Name = "NameRow"
    MingziPai.Size = UDim2.new(1, 0, 0, 28)
    MingziPai.Position = UDim2.new(0, 0, 0, 40)
    MingziPai.BackgroundTransparency = 1
    MingziPai.Parent = ZhixingZhengwen

    local RenameBox = Instance.new("TextBox")
    DaoyanZhuangtai.RenameBox = RenameBox
    RenameBox.Size = UDim2.new(1, -178, 1, 0)
    RenameBox.BackgroundColor3 = C.Field
    RenameBox.TextColor3 = Yanse.White
    RenameBox.PlaceholderText = "Script name"
    RenameBox.PlaceholderColor3 = Yanse.GreyMuted
    RenameBox.Text = dangqianDaoyanXiangka().Name
    RenameBox.TextSize = 11
    RenameBox.Font = Ziti.Medium
    RenameBox.ClearTextOnFocus = false
    RenameBox.TextXAlignment = Enum.TextXAlignment.Left
    RenameBox.TextTruncate = Enum.TextTruncate.AtEnd
    RenameBox.Parent = MingziPai
    chuangjianYuanjiao(RenameBox, 6)
    local chongmingMiaobian = chuangjianMiaobian(RenameBox, Yanse.Border, 1, 0.3)
    local chongmingBianju = Instance.new("UIPadding")
    chongmingBianju.PaddingLeft = UDim.new(0, 30)
    chongmingBianju.PaddingRight = UDim.new(0, 9)
    chongmingBianju.Parent = RenameBox

    local pencil = UI.Icon("pencil", RenameBox, Yanse.GreyMuted, 14)
    pencil.Root.AnchorPoint = Vector2.new(0, 0.5)
    pencil.Root.Position = UDim2.new(0, -21, 0.5, 0)

    RenameBox.Focused:Connect(function()
        Tween(chongmingMiaobian, 0.15, {Color = Yanse.White, Transparency = 0.1})
        pencil.Paint(Yanse.White, 0.15)
    end)
    RenameBox.FocusLost:Connect(function()
        Tween(chongmingMiaobian, 0.15, {Color = Yanse.Border, Transparency = 0.3})
        pencil.Paint(Yanse.GreyMuted, 0.15)
        local tab = dangqianDaoyanXiangka()
        if tab and RenameBox.Text ~= tab.Name then
            chongmingHuoyueDaoyanXiangka(RenameBox.Text)
        end
    end)

    local Tongji = Instance.new("TextLabel")
    Tongji.Name = "Stats"
    Tongji.AnchorPoint = Vector2.new(1, 0)
    Tongji.Position = UDim2.new(1, 0, 0, 0)
    Tongji.Size = UDim2.new(0, 168, 1, 0)
    Tongji.BackgroundTransparency = 1
    Tongji.Text = "Ln 1, Col 1  ·  0 chars"
    Tongji.TextColor3 = Yanse.GreyMuted
    Tongji.Font = Ziti.Medium
    Tongji.TextSize = 10
    Tongji.TextXAlignment = Enum.TextXAlignment.Right
    Tongji.TextTruncate = Enum.TextTruncate.AtEnd
    Tongji.Parent = MingziPai

    local Shell = Instance.new("Frame")
    Shell.Name = "EditorShell"
    Shell.Size = UDim2.new(1, 0, 1, -120)
    Shell.Position = UDim2.new(0, 0, 0, 74)
    Shell.BackgroundColor3 = C.Shell
    Shell.BorderSizePixel = 0
    Shell.ClipsDescendants = true
    Shell.Parent = ZhixingZhengwen
    chuangjianYuanjiao(Shell, 6)
    local WaikeMiaobian = chuangjianMiaobian(Shell, Yanse.Border, 1, 0.2)

    local hanghaoW = 40

    local HanghaoCaiqie = Instance.new("Frame")
    HanghaoCaiqie.Name = "Gutter"
    HanghaoCaiqie.Position = UDim2.new(0, 2, 0, 2)
    HanghaoCaiqie.Size = UDim2.new(0, hanghaoW - 2, 1, -4)
    HanghaoCaiqie.BackgroundTransparency = 1
    HanghaoCaiqie.ClipsDescendants = true
    HanghaoCaiqie.Active = true
    HanghaoCaiqie.Parent = Shell

    local HanghaoBiaoqian = Instance.new("TextLabel")
    HanghaoBiaoqian.Name = "Numbers"
    HanghaoBiaoqian.Size = UDim2.new(1, 0, 0, 0)
    HanghaoBiaoqian.AutomaticSize = Enum.AutomaticSize.Y
    HanghaoBiaoqian.BackgroundTransparency = 1
    HanghaoBiaoqian.Text = "1"
    HanghaoBiaoqian.TextColor3 = C.Gutter
    HanghaoBiaoqian.Font = Enum.Font.Code
    HanghaoBiaoqian.TextSize = shiShouji and 12 or 13
    HanghaoBiaoqian.TextXAlignment = Enum.TextXAlignment.Right
    HanghaoBiaoqian.TextYAlignment = Enum.TextYAlignment.Top
    HanghaoBiaoqian.Parent = HanghaoCaiqie
    local hanghaoBianju = Instance.new("UIPadding")
    hanghaoBianju.PaddingTop = UDim.new(0, PAD_TOP)
    hanghaoBianju.PaddingRight = UDim.new(0, 8)
    hanghaoBianju.Parent = HanghaoBiaoqian

    local Fengexian = Instance.new("Frame")
    Fengexian.Name = "Divider"
    Fengexian.Position = UDim2.new(0, hanghaoW, 0, 8)
    Fengexian.Size = UDim2.new(0, 1, 1, -16)
    Fengexian.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    Fengexian.BorderSizePixel = 0
    Fengexian.Parent = Shell

    local Gundong = Instance.new("ScrollingFrame")
    Gundong.Name = "EditorScroll"
    Gundong.Position = UDim2.new(0, hanghaoW + 1, 0, 2)
    Gundong.Size = UDim2.new(1, -(hanghaoW + 3), 1, -4)
    Gundong.BackgroundTransparency = 1
    Gundong.BorderSizePixel = 0
    Gundong.ScrollBarThickness = shiShouji and 6 or 5
    Gundong.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
    Gundong.ScrollBarImageTransparency = 0.25
    Gundong.ElasticBehavior = Enum.ElasticBehavior.Never
    Gundong.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    Gundong.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    Gundong.CanvasSize = UDim2.new(0, 0, 0, 0)
    Gundong.Parent = Shell

    DaimaShuru.Name = "CodeInput"
    DaimaShuru.Position = UDim2.new(0, 0, 0, 0)
    DaimaShuru.BackgroundTransparency = 1
    DaimaShuru.BackgroundColor3 = C.Shell
    DaimaShuru.Text = dangqianDaoyanXiangka().Script
    DaimaShuru.TextColor3 = C.Ink
    DaimaShuru.Font = Enum.Font.Code
    DaimaShuru.TextSize = shiShouji and 12 or 13
    DaimaShuru.TextXAlignment = Enum.TextXAlignment.Left
    DaimaShuru.TextYAlignment = Enum.TextYAlignment.Top
    DaimaShuru.ClearTextOnFocus = false
    DaimaShuru.MultiLine = true
    DaimaShuru.TextWrapped = true
    DaimaShuru.PlaceholderText = "-- paste or write your script here"
    DaimaShuru.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    DaimaShuru.Parent = Gundong

    local DaimaBianju = Instance.new("UIPadding")
    DaimaBianju.PaddingTop = UDim.new(0, PAD_TOP)
    DaimaBianju.PaddingLeft = UDim.new(0, BIANJU_X)
    DaimaBianju.PaddingRight = UDim.new(0, BIANJU_X)
    DaimaBianju.PaddingBottom = UDim.new(0, 12)
    DaimaBianju.Parent = DaimaShuru

    local Beam = Instance.new("Frame")
    Beam.Name = "Beam"
    Beam.Position = UDim2.new(-0.34, 0, 0, 0)
    Beam.Size = UDim2.new(0.34, 0, 0, 2)
    Beam.BackgroundColor3 = Yanse.BrandRed
    Beam.BorderSizePixel = 0
    Beam.ZIndex = 20
    Beam.Parent = Shell
    local guangshuDanchu = Instance.new("UIGradient")
    guangshuDanchu.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    guangshuDanchu.Parent = Beam

    local function saoguo()
        Beam.Position = UDim2.new(-0.34, 0, 0, 0)
        Tween(Beam, 0.6, {Position = UDim2.new(1, 0, 0, 0)}, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
    end

    local function douyi()
        task.spawn(function()
            local base = UDim2.new(0, 0, 0, 74)
            for _, dx in ipairs({-5, 5, -3, 3, 0}) do
                Tween(Shell, 0.04, {Position = base + UDim2.new(0, dx, 0, 0)})
                task.wait(0.045)
            end
            Shell.Position = base
        end)
    end

    local huanhangKai = true
    local minW, minH = 40, 40

    local function tongbuZuixiaoDaxiao()
        minH = math.max(Gundong.AbsoluteSize.Y - (huanhangKai and 0 or 12), 40)
        minW = math.max(Gundong.AbsoluteSize.X - 12, 40)
        if huanhangKai then
            DaimaShuru.Size = UDim2.new(1, 0, 0, minH)
        else
            DaimaShuru.Size = UDim2.new(0, minW, 0, minH)
        end
    end

    local function yingyongHanghaoKuandu(lineCount)
        local weishu = #tostring(lineCount)
        local w = math.max(36, math.floor(weishu * DaimaShuru.TextSize * 0.62 + 24))
        if w == hanghaoW then return end
        hanghaoW = w
        HanghaoCaiqie.Size = UDim2.new(0, hanghaoW - 2, 1, -4)
        Fengexian.Position = UDim2.new(0, hanghaoW, 0, 8)
        Gundong.Position = UDim2.new(0, hanghaoW + 1, 0, 2)
        Gundong.Size = UDim2.new(1, -(hanghaoW + 3), 1, -4)
    end

    local function celiang(text, kuandu)
        local ok, v = pcall(function()
            local shucan = Instance.new("GetTextBoundsParams")
            shucan.Text = text
            shucan.Font = DaimaShuru.FontFace
            shucan.Size = DaimaShuru.TextSize
            shucan.Width = kuandu
            return WenbenFuwu:GetTextBoundsAsync(shucan)
        end)
        if ok then return v end
        return nil
    end

    local hanghaoLingpai = 0
    local function shuaxinHanghao()
        hanghaoLingpai += 1
        local my = hanghaoLingpai
        task.delay(0.05, function()
            if my ~= hanghaoLingpai or not HanghaoBiaoqian.Parent then return end
            local lines = string.split(DaimaShuru.Text, "\n")
            local n = #lines
            yingyongHanghaoKuandu(n)
            local out = table.create(n)
            local keyongW = DaimaShuru.AbsoluteSize.X - BIANJU_X * 2
            local jiandan = (not huanhangKai) or n > 3000 or keyongW < 40
            if jiandan then
                for i = 1, n do out[i] = tostring(i) end
            else
                local size = DaimaShuru.TextSize
                local one = celiang("Ag", 100000)
                if my ~= hanghaoLingpai then return end
                local hangH = one and one.Y or size * 1.2
                local cishu = 0
                for i = 1, n do
                    local line = lines[i]
                    local rows = 1

                    if #line * size * 0.62 > keyongW * 0.98 then
                        if cishu < 60 then
                            cishu += 1
                            local v = celiang(line, keyongW)
                            if my ~= hanghaoLingpai then return end
                            if v then rows = math.max(1, math.floor(v.Y / hangH + 0.5)) end
                        else
                            rows = math.max(1, math.ceil(#line * size * 0.55 / keyongW))
                        end
                    end
                    out[i] = rows > 1 and (tostring(i) .. string.rep("\n", rows - 1)) or tostring(i)
                end
            end
            HanghaoBiaoqian.Text = table.concat(out, "\n")
        end)
    end

    Gundong:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        HanghaoBiaoqian.Position = UDim2.new(0, 0, 0, -Gundong.CanvasPosition.Y)
    end)

    HanghaoCaiqie.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseWheel then
            local y = math.max(Gundong.CanvasPosition.Y - input.Position.Z * 54, 0)
            Gundong.CanvasPosition = Vector2.new(Gundong.CanvasPosition.X, y)
        end
    end)

    local gensuiLingpai = 0
    local function gensuiZhizhen()
        if not DaimaShuru:IsFocused() then return end
        local cur = DaimaShuru.CursorPosition
        if cur < 1 then return end
        gensuiLingpai += 1
        local my = gensuiLingpai
        task.spawn(function()
            local qian = DaimaShuru.Text:sub(1, cur - 1)
            local zuihouHang = qian:match("([^\n]*)$") or ""
            local size = DaimaShuru.TextSize
            local keyongW = DaimaShuru.AbsoluteSize.X - BIANJU_X * 2
            local tall = celiang(qian .. "|", huanhangKai and math.max(keyongW, 40) or 100000)
            local one = celiang("Ag", 100000)
            if my ~= gensuiLingpai then return end
            local hangH = one and one.Y or size * 1.2
            local dibu = PAD_TOP + (tall and tall.Y or hangH)
            local top = dibu - hangH
            local cp = Gundong.CanvasPosition
            local win = Gundong.AbsoluteWindowSize
            local newY, newX = cp.Y, cp.X
            if top < cp.Y then
                newY = top - 4
            elseif dibu > cp.Y + win.Y then
                newY = dibu - win.Y + 6
            end
            if not huanhangKai then
                local wide = celiang(zuihouHang .. "|", 100000)
                if my ~= gensuiLingpai then return end
                local curX = BIANJU_X + (wide and wide.X or 0)
                if curX < cp.X + 12 then
                    newX = curX - 40
                elseif curX > cp.X + win.X - 12 then
                    newX = curX - win.X + 40
                end
            end
            newX, newY = math.max(newX, 0), math.max(newY, 0)
            if newX ~= cp.X or newY ~= cp.Y then
                Gundong.CanvasPosition = Vector2.new(newX, newY)
            end
        end)
    end

    local function gengxinTongji()
        local text = DaimaShuru.Text
        local cur = DaimaShuru.CursorPosition
        local ln, col = 1, 1
        if cur > 0 then
            local qian = text:sub(1, cur - 1)
            ln = select(2, qian:gsub("\n", "")) + 1
            col = #(qian:match("([^\n]*)$") or "") + 1
        end
        Tongji.Text = string.format("Ln %d, Col %d  ·  %d chars", ln, col, #text)
    end

    local DongzuoPai = Instance.new("Frame")
    DongzuoPai.Name = "ActionRow"
    DongzuoPai.Size = UDim2.new(1, 0, 0, 40)
    DongzuoPai.Position = UDim2.new(0, 0, 1, -40)
    DongzuoPai.BackgroundTransparency = 1
    DongzuoPai.Parent = ZhixingZhengwen

    local btnDaxiao = shiShouji and 34 or 32
    local biaoqianBtnW = shiShouji and btnDaxiao or 78
    local ztBaoliu = 112 + 3 * biaoqianBtnW + 4 * 8 + 14

    local Dot = Instance.new("Frame")
    Dot.Name = "StatusDot"
    Dot.AnchorPoint = Vector2.new(0, 0.5)
    Dot.Position = UDim2.new(0, 4, 0.5, 0)
    Dot.Size = UDim2.new(0, 8, 0, 8)
    Dot.BackgroundColor3 = C.Idle
    Dot.BorderSizePixel = 0
    Dot.Parent = DongzuoPai
    chuangjianYuanjiao(Dot, 4)
    DonghuaFuwu:Create(Dot, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        BackgroundTransparency = 0.7
    }):Play()

    local Status = Instance.new("TextLabel")
    DaoyanZhuangtai.Status = Status
    Status.Name = "Status"
    Status.Position = UDim2.new(0, 20, 0, 0)
    Status.Size = UDim2.new(1, -(ztBaoliu + 20), 1, 0)
    Status.BackgroundTransparency = 1
    Status.Text = "Ready · auto-save on"
    Status.TextColor3 = Yanse.GreyMuted
    Status.Font = Ziti.Medium
    Status.TextSize = 11
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.TextTruncate = Enum.TextTruncate.AtEnd
    Status.Parent = DongzuoPai

    local function tuseZt()
        local t = Status.Text
        local dot, ink = C.Idle, Yanse.GreyMuted
        if t:find("^Error") or t:find("^Failed") then
            dot, ink = C.Bad, C.BadText
        elseif t:find("^Running") then
            dot = Yanse.BrandRed
        elseif t:find("^Executed") or t:find("^Saved") or t:find("^Copied") or t:find("^Cleared") or t:find("^Switched") then
            dot = C.Ok
        end
        Tween(Dot, 0.2, {BackgroundColor3 = dot})
        Tween(Status, 0.2, {TextColor3 = ink})
    end
    Status:GetPropertyChangedSignal("Text"):Connect(tuseZt)

    local Buttons = Instance.new("Frame")
    Buttons.Name = "Buttons"
    Buttons.AnchorPoint = Vector2.new(1, 0.5)
    Buttons.Position = UDim2.new(1, 0, 0.5, 0)
    Buttons.Size = UDim2.new(0, 0, 1, 0)
    Buttons.AutomaticSize = Enum.AutomaticSize.X
    Buttons.BackgroundTransparency = 1
    Buttons.Parent = DongzuoPai
    local AnniuBuju2 = Instance.new("UIListLayout")
    AnniuBuju2.FillDirection = Enum.FillDirection.Horizontal
    AnniuBuju2.HorizontalAlignment = Enum.HorizontalAlignment.Right
    AnniuBuju2.VerticalAlignment = Enum.VerticalAlignment.Center
    AnniuBuju2.SortOrder = Enum.SortOrder.LayoutOrder
    AnniuBuju2.Padding = UDim.new(0, 8)
    AnniuBuju2.Parent = Buttons

    local function gongjuAnniu(btn, kind, label, order)
        btn.Size = UDim2.new(0, biaoqianBtnW, 0, btnDaxiao)
        btn.BackgroundColor3 = C.Panel
        btn.Text = shiShouji and "" or label
        btn.TextColor3 = Yanse.GreyLight
        btn.Font = Ziti.Bold
        btn.TextSize = 12
        btn.AutoButtonColor = false
        btn.ClipsDescendants = true
        btn.LayoutOrder = order
        btn.Parent = Buttons
        chuangjianYuanjiao(btn, 6)
        chuangjianMiaobian(btn, Yanse.Border, 1, 0.3)
        BangdingJiaohuShengyin(btn)
        local icon = UI.Icon(kind, btn, Yanse.GreyLight, 15)
        if not shiShouji then
            icon.Root.Position = UDim2.new(0, 15, 0.5, 0)
            btn.TextXAlignment = Enum.TextXAlignment.Center
        end
        btn.MouseEnter:Connect(function()
            icon.Paint(Yanse.White, 0.12)
            Tween(btn, 0.12, {TextColor3 = Yanse.White})
        end)
        btn.MouseLeave:Connect(function()
            icon.Paint(Yanse.GreyLight, 0.12)
            Tween(btn, 0.12, {TextColor3 = Yanse.GreyLight})
        end)
        btn.MouseButton1Down:Connect(function() UI.Ripple(btn) end)
        return icon
    end

    local HuanhangBtn = Instance.new("TextButton")
    HuanhangBtn.Name = "WrapBtn"
    local huanhangTubiao = gongjuAnniu(HuanhangBtn, "lines", "Wrap", 1)

    local function huanhangJingzhi()
        return huanhangKai and C.PanelOn or C.Panel
    end
    local function tuseHuanhang()
        Tween(HuanhangBtn, 0.15, {BackgroundColor3 = huanhangJingzhi()})
        huanhangTubiao.Paint(huanhangKai and Yanse.White or Yanse.GreyLight, 0.15)
    end
    HuanhangBtn.MouseEnter:Connect(function() Tween(HuanhangBtn, 0.12, {BackgroundColor3 = C.PanelHover}) end)
    HuanhangBtn.MouseLeave:Connect(function() Tween(HuanhangBtn, 0.12, {BackgroundColor3 = huanhangJingzhi()}) end)

    local function yingyongHuanhang(on)
        huanhangKai = on
        Shezhi.DirectorWrap = on
        if on then
            Gundong.ScrollingDirection = Enum.ScrollingDirection.Y
            Gundong.AutomaticCanvasSize = Enum.AutomaticSize.Y
            Gundong.CanvasSize = UDim2.new(0, 0, 0, 0)
            DaimaShuru.TextWrapped = true
            DaimaShuru.AutomaticSize = Enum.AutomaticSize.Y
            Gundong.CanvasPosition = Vector2.new(0, Gundong.CanvasPosition.Y)
        else
            Gundong.ScrollingDirection = Enum.ScrollingDirection.XY
            Gundong.AutomaticCanvasSize = Enum.AutomaticSize.XY
            Gundong.CanvasSize = UDim2.new(0, 0, 0, 0)
            DaimaShuru.TextWrapped = false
            DaimaShuru.AutomaticSize = Enum.AutomaticSize.XY
        end
        tongbuZuixiaoDaxiao()
        shuaxinHanghao()
        tuseHuanhang()
    end

    HuanhangBtn.MouseButton1Click:Connect(function()
        yingyongHuanhang(not huanhangKai)
        baocunShezhi()
        Status.Text = huanhangKai and "Word wrap on" or "Word wrap off · scroll sideways for long lines"
    end)

    local FuzhiBtn = Instance.new("TextButton")
    FuzhiBtn.Name = "CopyBtn"
    local fuzhiTubiao = gongjuAnniu(FuzhiBtn, "copy", "Copy", 2)
    local jianchaTubiao = UI.Icon("check", FuzhiBtn, C.Ok, 15)
    jianchaTubiao.Root.Position = fuzhiTubiao.Root.Position
    jianchaTubiao.Root.Visible = false
    FuzhiBtn.MouseEnter:Connect(function() Tween(FuzhiBtn, 0.12, {BackgroundColor3 = C.PanelHover}) end)
    FuzhiBtn.MouseLeave:Connect(function() Tween(FuzhiBtn, 0.12, {BackgroundColor3 = C.Panel}) end)

    local fuzhiId = 0
    FuzhiBtn.MouseButton1Click:Connect(function()
        local text = DaimaShuru.Text
        if text == "" then
            Status.Text = "Nothing to copy yet"
            return
        end
        if not setclipboard then
            Status.Text = "Error: this executor has no clipboard support"
            return
        end
        setclipboard(text)
        Status.Text = "Copied to clipboard"
        fuzhiId += 1
        local my = fuzhiId
        fuzhiTubiao.Root.Visible = false
        jianchaTubiao.Root.Visible = true
        task.delay(1.3, function()
            if my ~= fuzhiId then return end
            fuzhiTubiao.Root.Visible = true
            jianchaTubiao.Root.Visible = false
        end)
    end)

    local qingkongTubiao = gongjuAnniu(ZhixingQingkongBtn, "trash", "Clear", 3)
    ZhixingQingkongBtn.MouseButton1Click:Connect(function()
        DaimaShuru.Text = ""
        baocunHuoyueDaoyanXiangka()
        Gundong.CanvasPosition = Vector2.new(0, 0)
        Status.Text = "Cleared · Saved"
    end)

    ZhixingDongzuoBtn.Size = UDim2.new(0, 112, 0, btnDaxiao + 2)
    ZhixingDongzuoBtn.BackgroundColor3 = Yanse.BrandRed
    ZhixingDongzuoBtn.Text = "Execute"
    ZhixingDongzuoBtn.Font = Ziti.Bold
    ZhixingDongzuoBtn.TextSize = 12
    ZhixingDongzuoBtn.TextColor3 = Yanse.White
    ZhixingDongzuoBtn.AutoButtonColor = false
    ZhixingDongzuoBtn.ClipsDescendants = true
    ZhixingDongzuoBtn.LayoutOrder = 4
    ZhixingDongzuoBtn.Parent = Buttons
    chuangjianYuanjiao(ZhixingDongzuoBtn, 6)
    BangdingJiaohuShengyin(ZhixingDongzuoBtn)
    local bofangTubiao = UI.Icon("play", ZhixingDongzuoBtn, Yanse.White, 15)
    bofangTubiao.Root.Position = UDim2.new(0, 17, 0.5, 0)
    ZhixingDongzuoBtn.MouseEnter:Connect(function()
        Tween(bofangTubiao.Root, 0.18, {Position = UDim2.new(0, 21, 0.5, 0)}, Enum.EasingStyle.Cubic)
    end)
    ZhixingDongzuoBtn.MouseLeave:Connect(function()
        Tween(bofangTubiao.Root, 0.18, {Position = UDim2.new(0, 17, 0.5, 0)}, Enum.EasingStyle.Cubic)
    end)
    ZhixingDongzuoBtn.MouseButton1Down:Connect(function() UI.Ripple(ZhixingDongzuoBtn) end)

    local yunxingId = 0
    ZhixingDongzuoBtn.MouseButton1Click:Connect(function()
        baocunHuoyueDaoyanXiangka()
        yunxingId += 1
        local my = yunxingId
        Status.Text = "Running…"
        saoguo()
        task.spawn(function()
            local result = {ok = true}
            local fn, compileErr = loadstring(DaimaShuru.Text)
            if not fn then
                result.ok, result.err = false, compileErr
            else
                local wancheng = false
                task.spawn(function()
                    local s, e = pcall(fn)
                    result.ok, result.err = s, e
                    wancheng = true
                end)

                local t0 = os.clock()
                while not wancheng and os.clock() - t0 < 0.4 do task.wait() end
            end

            ZhixingDongzuoBtn.Text = result.ok and "Executed" or "Failed"
            if result.ok then
                Status.Text = "Executed"
            else
                local msg = tostring(result.err or "unknown error"):gsub("\n.*", "")
                if #msg > 90 then msg = msg:sub(1, 90) .. "…" end
                Status.Text = "Error: " .. msg
                douyi()
            end

            task.wait(1.2)
            if my == yunxingId and ZhixingDongzuoBtn then ZhixingDongzuoBtn.Text = "Execute" end
            if not result.ok then
                task.wait(5)
                if my == yunxingId and Status.Text:find("^Error") then Status.Text = "Ready · auto-save on" end
            end
        end)
    end)

    -- 自动补全
    local AC_QIYONG = true
    local AC_JINRU_JIESHOU = true
    local AC_PAI_H = shiShouji and 34 or 24
    local AC_ZUIDA_PAI = shiShouji and 5 or 8
    local AC_ZUIDA_JIEGUO = 40
    local AC_Z = 80
    local AC_MINGZI_X = 34
    local AC_PIPEI = "#4DA6FF"

    local KIND = {
        keyword = {icon = "kw",    color = Color3.fromRGB(214, 220, 232)},
        class   = {icon = "node",  color = Color3.fromRGB(245, 166, 35)},
        field   = {icon = "field", color = Color3.fromRGB(77, 166, 255)},
        func    = {icon = "cube",  color = Color3.fromRGB(176, 124, 240)},
        snippet = {icon = "doc",   color = Color3.fromRGB(86, 200, 170)}
    }

    local function ci(kind, str, out)
        for w in str:gmatch("%S+") do out[#out + 1] = {n = w, k = kind} end
        return out
    end

    local GUANJIANCI_LIEBIAO = "and break continue do else elseif end false for function if in local nil not or repeat return then true until while"

    local Fuwu = ci("class", [[
        Players Workspace Lighting ReplicatedStorage ReplicatedFirst ServerStorage ServerScriptService
        StarterGui StarterPack StarterPlayer SoundService CoreGui Teams Debris CollectionService
        ContextActionService MarketplaceService TeleportService GuiService VirtualUser VirtualInputManager
        PathfindingService ProximityPromptService LocalizationService HttpService RunService
        UserInputService TweenService TextService TextChatService Chat PolicyService BadgeService
        GroupService SocialService Stats ScriptContext LogService AnalyticsService MaterialService
        AssetService ContentProvider InsertService PhysicsService
    ]], {})

    local Quanju = {}
    ci("keyword", GUANJIANCI_LIEBIAO, Quanju)
    ci("func", [[
        print warn error assert pcall xpcall pairs ipairs next select tostring tonumber type typeof
        require loadstring setmetatable getmetatable rawget rawset rawequal rawlen unpack tick time wait
        spawn delay collectgarbage newproxy getfenv setfenv
    ]], Quanju)
    ci("field", "game workspace script shared _G _VERSION math string table task os coroutine debug utf8 bit32 Drawing crypt", Quanju)

    ci("func", [[
        writefile readfile appendfile isfile isfolder makefolder delfolder delfile listfiles loadfile dofile
        getgenv getrenv getreg getgc getinstances getnilinstances getscripts getloadedmodules getconnections
        firesignal fireclickdetector fireproximityprompt firetouchinterest hookfunction hookmetamethod
        newcclosure checkcaller getrawmetatable setrawmetatable setreadonly isreadonly getnamecallmethod
        setnamecallmethod setclipboard toclipboard request http_request queue_on_teleport identifyexecutor
        getexecutorname setfpscap getcustomasset decompile getscriptbytecode getscriptclosure cloneref
        compareinstances clonefunction iscclosure islclosure gethui gethiddenproperty sethiddenproperty
        setsimulationradius mouse1click mouse1press mouse1release mousemoverel mousemoveabs mousescroll
        keypress keyrelease keyclick saveinstance base64_encode base64_decode getcallingscript
        getthreadidentity setthreadidentity getupvalue getupvalues setupvalue getconstants getconstant
        getprotos getstack lz4compress lz4decompress
    ]], Quanju)
    for _, s in ipairs(Fuwu) do Quanju[#Quanju + 1] = s end
    ci("class", [[
        Instance Enum Vector3 Vector2 CFrame Color3 UDim2 UDim Rect Ray Region3 BrickColor NumberRange
        NumberSequence ColorSequence TweenInfo Random RaycastParams OverlapParams Font Axes Faces
        PhysicalProperties Part MeshPart WedgePart Model Folder Script LocalScript ModuleScript RemoteEvent
        RemoteFunction BindableEvent BindableFunction ScreenGui Frame TextLabel TextButton TextBox ImageLabel
        ImageButton ScrollingFrame ViewportFrame CanvasGroup UICorner UIStroke UIListLayout UIGridLayout
        UIPadding UIGradient UIScale UIAspectRatioConstraint UISizeConstraint Sound Humanoid Tool Animation
        Animator Attachment BodyVelocity BodyPosition BodyGyro Highlight Beam Trail ParticleEmitter
        PointLight SpotLight ClickDetector ProximityPrompt Seat SpawnLocation Decal Texture Weld
        WeldConstraint Motor6D Camera StringValue NumberValue BoolValue IntValue ObjectValue Color3Value
    ]], Quanju)

    local Pianduan = {
        {n = "fori",       ins = "for i = 1, $0 do\n    \nend"},
        {n = "forp",       ins = "for _, v in pairs($0) do\n    \nend"},
        {n = "forip",      ins = "for i, v in ipairs($0) do\n    \nend"},
        {n = "whiledo",    ins = "while $0 do\n    task.wait()\nend"},
        {n = "ifthen",     ins = "if $0 then\n    \nend"},
        {n = "localfn",    ins = "local function $0()\n    \nend"},
        {n = "pcallf",     ins = "local ok, err = pcall(function()\n    $0\nend)"},
        {n = "spawnf",     ins = "task.spawn(function()\n    $0\nend)"},
        {n = "getservice", ins = "game:GetService(\"$0\")"}
    }
    for _, s in ipairs(Pianduan) do
        s.k = "snippet"
        Quanju[#Quanju + 1] = s
    end

    local QUANJU_SHEZHI, KEYWORD_SET = {}, {}
    for _, it in ipairs(Quanju) do QUANJU_SHEZHI[it.n] = true end
    for w in GUANJIANCI_LIEBIAO:gmatch("%S+") do KEYWORD_SET[w] = true end

    local Chengyuan = {}
    local function lib(mingzi, funcs, fields)
        local list = {}
        ci("func", funcs or "", list)
        ci("field", fields or "", list)
        for n in mingzi:gmatch("%S+") do Chengyuan[n] = list end
    end
    lib("math", "abs acos asin atan atan2 ceil clamp cos cosh deg exp floor fmod frexp ldexp log log10 max min modf noise pow rad random randomseed round sign sin sinh sqrt tan tanh", "pi huge")
    lib("string", "byte char find format gmatch gsub len lower match pack packsize rep reverse split sub unpack upper")
    lib("table", "clear clone concat create find freeze insert isfrozen maxn move pack remove sort unpack")
    lib("task", "cancel defer delay desynchronize spawn synchronize wait")
    lib("os", "clock date difftime time")
    lib("coroutine", "close create isyieldable resume running status wrap yield")
    lib("debug", "info profilebegin profileend traceback")
    lib("utf8", "char codepoint codes len offset", "charpattern")
    lib("Instance", "new")
    lib("Vector3", "new FromNormalId FromAxis", "zero one xAxis yAxis zAxis")
    lib("Vector2", "new", "zero one xAxis yAxis")
    lib("CFrame", "new Angles lookAt fromEulerAnglesXYZ fromEulerAnglesYXZ fromOrientation fromAxisAngle fromMatrix", "identity")
    lib("Color3", "new fromRGB fromHSV fromHex")
    lib("UDim2", "new fromScale fromOffset")
    lib("UDim", "new")
    lib("TweenInfo", "new")
    lib("BrickColor", "new random palette")
    lib("Random", "new")
    lib("Enum", nil, "KeyCode UserInputType Material EasingStyle EasingDirection Font HumanoidStateType RaycastFilterType NormalId PartType SortOrder TextXAlignment TextYAlignment FillDirection")
    lib("game", "GetService HttpGet HttpGetAsync FindFirstChild FindFirstChildOfClass WaitForChild IsLoaded GetFullName IsA", "PlaceId GameId JobId PlaceVersion Players Workspace Lighting ReplicatedStorage StarterGui CoreGui Loaded")
    lib("workspace", "Raycast FindFirstChild GetChildren WaitForChild GetServerTimeNow", "CurrentCamera Gravity Terrain DistributedGameTime FallenPartsDestroyHeight")
    lib("Players players", "GetPlayers GetPlayerByUserId GetPlayerFromCharacter GetUserIdFromNameAsync GetNameFromUserIdAsync FindFirstChild", "LocalPlayer PlayerAdded PlayerRemoving MaxPlayers")
    lib("LocalPlayer localPlayer lp plr", "Kick GetMouse LoadCharacter Move GetRankInGroup IsFriendsWith", "Character CharacterAdded CharacterRemoving UserId Name DisplayName Team TeamColor AccountAge PlayerGui Backpack Neutral CameraMode")
    lib("RunService", "BindToRenderStep UnbindFromRenderStep IsStudio IsClient IsServer IsRunning", "Heartbeat RenderStepped Stepped PreRender PreSimulation PostSimulation")
    lib("UserInputService", "IsKeyDown GetMouseLocation GetMouseDelta GetKeysPressed IsMouseButtonPressed GetFocusedTextBox", "InputBegan InputEnded InputChanged TouchEnabled KeyboardEnabled MouseEnabled GamepadEnabled MouseBehavior MouseIconEnabled")
    lib("TweenService", "Create GetValue")
    lib("HttpService", "JSONEncode JSONDecode GenerateGUID UrlEncode RequestAsync GetAsync PostAsync")

    local TONGYONG_FANGFA = ci("func", [[
        Clone Destroy ClearAllChildren FindFirstChild FindFirstChildOfClass FindFirstChildWhichIsA
        FindFirstAncestor FindFirstAncestorOfClass FindFirstAncestorWhichIsA GetChildren GetDescendants
        GetFullName GetAttribute SetAttribute GetAttributes GetPropertyChangedSignal IsA IsDescendantOf
        IsAncestorOf WaitForChild GetService Connect Once Disconnect Wait Fire FireServer FireClient
        InvokeServer Invoke Play Stop Pause LoadAnimation MoveTo Move Kick TakeDamage ChangeState
        EquipTool UnequipTools GetState GetPivot PivotTo GetBoundingBox TranslateBy ApplyImpulse GetMass
        GetTouchingParts SetNetworkOwner GetNetworkOwner Raycast
    ]], {})
    local TONGYONG_ZIDUAN = ci("field", [[
        Parent Name ClassName Position Size CFrame Orientation Rotation Anchored CanCollide CanTouch
        CanQuery Transparency Color Material Massless Velocity AssemblyLinearVelocity
        AssemblyAngularVelocity Text Visible BackgroundColor3 BackgroundTransparency TextColor3 TextSize
        Font Image ZIndex Active AnchorPoint Health MaxHealth WalkSpeed JumpPower JumpHeight HipHeight
        Character Humanoid HumanoidRootPart Head Torso PrimaryPart Value Enabled Looped Volume SoundId
        TimePosition IsPlaying Changed Touched TouchEnded ChildAdded ChildRemoved DescendantAdded
        DescendantRemoving AncestryChanged Destroying Died HealthChanged Running Jumping StateChanged
        MouseButton1Click MouseButton1Down MouseButton1Up MouseButton2Click MouseEnter MouseLeave Activated
        InputBegan InputEnded InputChanged FocusLost Focused Triggered TriggerEnded OnClientEvent
        OnServerEvent Completed
    ]], {})
    local TONGYONG_QUAN = {}
    for _, it in ipairs(TONGYONG_ZIDUAN) do TONGYONG_QUAN[#TONGYONG_QUAN + 1] = it end
    for _, it in ipairs(TONGYONG_FANGFA) do TONGYONG_QUAN[#TONGYONG_QUAN + 1] = it end

    local function shiBianjie(name, s)
        if s == 1 then return true end
        local pc = name:sub(s - 1, s - 1)
        if pc == "_" then return true end
        return name:sub(s, s):match("%u") ~= nil and pc:match("%u") == nil
    end

    local function pipeiTongguo(name, xiaoxie, q, boundary)
        local idx, pos, prev, score = {}, 1, 0, 500
        for i = 1, #q do
            local c = q:sub(i, i)
            local p = xiaoxie:find(c, pos, true)
            if not p then return nil end
            if boundary then
                local s = p
                while s do
                    if shiBianjie(name, s) then
                        p = s
                        break
                    end
                    s = xiaoxie:find(c, s + 1, true)
                end
            end
            if p == prev + 1 then score += 16 end
            if shiBianjie(name, p) then score += 10 end
            score -= math.min(p - prev - 1, 8)
            idx[i] = p
            prev = p
            pos = p + 1
        end
        return score - #name * 0.5, idx
    end

    local function mohu(name, q, raw)
        local ql = #q
        local xiaoxie = name:lower()
        if xiaoxie:sub(1, ql) == q then
            local idx = table.create(ql)
            for i = 1, ql do idx[i] = i end
            return 2000 - #name + (name:sub(1, ql) == raw and 100 or 0), idx
        end
        if ql < 2 then return nil end
        local s, idx = pipeiTongguo(name, xiaoxie, q, true)
        if not s then s, idx = pipeiTongguo(name, xiaoxie, q, false) end
        return s, idx
    end

    local function saomiaoFuhao(text, skipWord)
        local seen, out = {}, {}
        local function add(n, kind)
            if #n < 2 or seen[n] or n == skipWord or KEYWORD_SET[n] or QUANJU_SHEZHI[n] then return end
            if #out >= 400 then return end
            seen[n] = true
            out[#out + 1] = {n = n, k = kind, doc = true}
        end
        for fname in text:gmatch("function%s+([%a_][%w_%.:]*)") do
            add(fname:match("([%a_][%w_]*)$") or fname, "func")
        end
        for line in text:gmatch("[^\n]+") do
            local mingzi = line:match("^%s*local%s+([%a_][%w_,%s]*)")
            if mingzi and not mingzi:match("^function") then
                for n in mingzi:gmatch("[%a_][%w_]*") do add(n, "field") end
            end
            local xunhuanBianliang = line:match("^%s*for%s+([%a_][%w_,%s]*)%s+in%s")
            if xunhuanBianliang then
                for n in xunhuanBianliang:gmatch("[%a_][%w_]*") do add(n, "field") end
            end
            local shucan = line:match("function%s*[%w_%.:]*%s*%(([^)]*)%)")
            if shucan then
                for n in shucan:gmatch("[%a_][%w_]*") do add(n, "field") end
            end
        end
        return out
    end

    local function zaiPinglunOrZifuchuan(line)
        local q
        local i, n = 1, #line
        while i <= n do
            local ch = line:sub(i, i)
            if q then
                if ch == "\\" then
                    i += 1
                elseif ch == q then
                    q = nil
                end
            else
                if ch == "-" and line:sub(i + 1, i + 1) == "-" then return true end
                if ch == "\"" or ch == "'" or ch == "`" then q = ch end
            end
            i += 1
        end
        return q ~= nil
    end

    local function shiShengming(line, run)
        if line:match("%f[%w_]local%s+$") then
            return ("function"):sub(1, #run) ~= run
        end
        return line:match("%f[%w_]function%s+$") ~= nil or line:match("%f[%w_]for%s+$") ~= nil
    end

    local Pop = {
        open = false, items = {}, sel = 1, text = "", ws = 0, we = 0, cursor = 0, run = "",
        cx = 0, cy = 0, lh = 16, w = 220, h = 60, token = 0, hold = 0,
        pending = false, suppress = false, mouseOver = false, pressedAt = -10, symbols = nil, lastLen = #DaimaShuru.Text
    }
    DaoyanZhuangtai.AC = {Holding = function() return os.clock() < Pop.hold end}

    local okZu, Root = pcall(function() return Instance.new("CanvasGroup") end)
    local shiZu = okZu and Root ~= nil
    if not shiZu then Root = Instance.new("Frame") end
    Root.Name = "AutocompleteList"
    Root.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    Root.BorderSizePixel = 0
    Root.Active = true
    Root.Visible = false
    Root.Size = UDim2.fromOffset(220, 60)
    Root.ZIndex = AC_Z
    Root.Parent = ZhixingZhengwen
    chuangjianYuanjiao(Root, 6)
    chuangjianMiaobian(Root, Yanse.Border, 1, 0.1)

    local List = Instance.new("ScrollingFrame")
    List.Name = "Items"
    List.Position = UDim2.fromOffset(4, 4)
    List.Size = UDim2.new(1, -8, 1, -8)
    List.BackgroundTransparency = 1
    List.BorderSizePixel = 0
    List.ScrollBarThickness = 3
    List.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
    List.ScrollBarImageTransparency = 0.3
    List.ScrollingDirection = Enum.ScrollingDirection.Y
    List.ElasticBehavior = Enum.ElasticBehavior.Never
    List.CanvasSize = UDim2.new(0, 0, 0, 0)
    List.AutomaticCanvasSize = Enum.AutomaticSize.Y
    List.ZIndex = AC_Z + 1
    List.Parent = Root

    local LiebiaoBuju = Instance.new("UIListLayout")
    LiebiaoBuju.SortOrder = Enum.SortOrder.LayoutOrder
    LiebiaoBuju.Parent = List

    local rows = {}
    local guanbiTanchuang, shezhiXuan, jieshouAnDianji

    local function huodePai(i)
        local r = rows[i]
        if r then return r end
        local btn = Instance.new("TextButton")
        btn.Name = "Item"
        btn.LayoutOrder = i
        btn.Size = UDim2.new(1, 0, 0, AC_PAI_H)
        btn.BackgroundColor3 = C.PanelHover
        btn.BackgroundTransparency = 1
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.Text = ""
        btn.ZIndex = AC_Z + 2
        btn.Parent = List
        chuangjianYuanjiao(btn, 4)

        local bar = Instance.new("Frame")
        bar.Name = "Bar"
        bar.AnchorPoint = Vector2.new(0, 0.5)
        bar.Position = UDim2.new(0, 0, 0.5, 0)
        bar.Size = UDim2.new(0, 2, 0, 14)
        bar.BackgroundColor3 = Yanse.BrandRed
        bar.BorderSizePixel = 0
        bar.Visible = false
        bar.ZIndex = AC_Z + 3
        bar.Parent = btn

        local holder = Instance.new("Frame")
        holder.Name = "IconHolder"
        holder.AnchorPoint = Vector2.new(0, 0.5)
        holder.Position = UDim2.new(0, 8, 0.5, 0)
        holder.Size = UDim2.new(0, 18, 0, 18)
        holder.BackgroundTransparency = 1
        holder.ZIndex = AC_Z + 3
        holder.Parent = btn

        local label = Instance.new("TextLabel")
        label.Name = "Name"
        label.Position = UDim2.new(0, AC_MINGZI_X, 0, 0)
        label.Size = UDim2.new(1, -(AC_MINGZI_X + 6), 1, 0)
        label.BackgroundTransparency = 1
        label.RichText = true
        label.Font = Enum.Font.Code
        label.TextSize = DaimaShuru.TextSize
        label.TextColor3 = C.Ink
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextTruncate = Enum.TextTruncate.AtEnd
        label.ZIndex = AC_Z + 3
        label.Parent = btn

        r = {btn = btn, bar = bar, holder = holder, label = label, kind = nil, icon = nil}
        rows[i] = r

        btn.MouseMoved:Connect(function()
            Pop.mouseOver = true
            if Pop.sel ~= i then shezhiXuan(i, false) end
        end)
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Pop.pressedAt = os.clock()
            end
        end)
        btn.Activated:Connect(function()
            jieshouAnDianji(i)
        end)
        return r
    end

    local function fuwenbenMingzi(name, idx)
        if not idx or #idx == 0 then return name end
        local mark = {}
        for _, p in ipairs(idx) do mark[p] = true end
        local out, open = {}, false
        for i = 1, #name do
            local on = mark[i] == true
            if on and not open then
                out[#out + 1] = "<font color=\"" .. AC_PIPEI .. "\">"
                open = true
            elseif open and not on then
                out[#out + 1] = "</font>"
                open = false
            end
            out[#out + 1] = name:sub(i, i)
        end
        if open then out[#out + 1] = "</font>" end
        return table.concat(out)
    end

    shezhiXuan = function(i, scrollTo)
        local n = #Pop.items
        if n == 0 then return end
        Pop.sel = i
        for k = 1, n do
            local r = rows[k]
            if r then
                local on = (k == i)
                r.btn.BackgroundTransparency = on and 0 or 1
                r.bar.Visible = on
            end
        end
        if scrollTo then
            local top = (i - 1) * AC_PAI_H
            local view = math.min(n, AC_ZUIDA_PAI) * AC_PAI_H
            local cp = List.CanvasPosition.Y
            if top < cp then
                List.CanvasPosition = Vector2.new(0, top)
            elseif top + AC_PAI_H > cp + view then
                List.CanvasPosition = Vector2.new(0, top + AC_PAI_H - view)
            end
        end
    end

    local zifuW = nil
    local zifuWDaxiao = nil
    local function huodeZifuW()
        local size = DaimaShuru.TextSize
        if zifuW and zifuWDaxiao == size then return zifuW end
        local v = celiang("MMMMMMMMMM", 100000)
        zifuW = (v and v.X > 0) and (v.X / 10) or size * 0.55
        zifuWDaxiao = size
        return zifuW
    end

    local function xuanranXiang()
        local n = #Pop.items
        local zuichang = 0
        for k = 1, math.max(n, #rows) do
            local item = Pop.items[k]
            if item then
                local r = huodePai(k)
                r.btn.Visible = true
                local kd = KIND[item.k]
                if r.kind ~= item.k then
                    if r.icon then r.icon.Root:Destroy() end
                    r.icon = UI.Icon(kd.icon, r.holder, kd.color, 15)
                    r.kind = item.k
                end
                r.label.TextSize = DaimaShuru.TextSize
                r.label.Text = fuwenbenMingzi(item.n, item.idx)
                if #item.n > zuichang then zuichang = #item.n end
            elseif rows[k] then
                rows[k].btn.Visible = false
            end
        end
        local w = math.clamp(math.floor(zuichang * (zifuW or DaimaShuru.TextSize * 0.55)) + AC_MINGZI_X + 24, 190, 380)
        Pop.w, Pop.h = w, math.min(n, AC_ZUIDA_PAI) * AC_PAI_H + 8
        Root.Size = UDim2.fromOffset(Pop.w, Pop.h)
        List.CanvasPosition = Vector2.new(0, 0)
        shezhiXuan(1, false)
    end

    local function changsuoTanchuang()
        if not Pop.open then return end
        local ap, win = Gundong.AbsolutePosition, Gundong.AbsoluteWindowSize
        local px = ap.X + BIANJU_X + Pop.cx - Gundong.CanvasPosition.X
        local paiDing = ap.Y + PAD_TOP + Pop.cy - Gundong.CanvasPosition.Y
        if paiDing + Pop.lh < ap.Y or paiDing > ap.Y + win.Y then
            Root.Visible = false
            return
        end
        local w, h = Pop.w, Pop.h
        local mp, ms = ZhuKuangjia.AbsolutePosition, ZhuKuangjia.AbsoluteSize
        local x = px - AC_MINGZI_X - 4
        local y = paiDing + Pop.lh + 4
        if y + h > mp.Y + ms.Y - 6 then
            local above = paiDing - h - 4
            if above >= mp.Y + 6 then y = above end
        end
        x = math.clamp(x, mp.X + 8, math.max(mp.X + ms.X - w - 8, mp.X + 8))
        local ep = ZhixingZhengwen.AbsolutePosition
        Root.Position = UDim2.fromOffset(x - ep.X, y - ep.Y)
        if not Root.Visible then
            Root.Visible = true
            if shiZu then
                Root.GroupTransparency = 1
                Tween(Root, 0.12, {GroupTransparency = 0})
            end
        end
    end

    guanbiTanchuang = function()
        Pop.token += 1
        Pop.symbols = nil
        if not Pop.open and not Root.Visible then return end
        Pop.open = false
        Pop.items = {}
        Root.Visible = false
    end

    local function zuihouPaiLieshu(line, cols)
        local used, i, n = 0, 1, #line
        while i <= n do
            local s, e = line:find("^%S+", i)
            local shiCi = s ~= nil
            if not s then s, e = line:find("^%s+", i) end
            local len = e - s + 1
            if shiCi then
                if used > 0 and used + len > cols then used = 0 end
                if len > cols then
                    used = ((len - 1) % cols) + 1
                else
                    used += len
                end
            else
                used += len
                if used > cols then used = used % cols end
            end
            i = e + 1
        end
        return used
    end

    local function guangbiaoZhibiao(text, ws)
        local qian = text:sub(1, ws - 1)
        local zuihouHang = qian:match("([^\n]*)$") or ""
        local one = celiang("Ag", 100000)
        local hangH = one and one.Y or DaimaShuru.TextSize * 1.2
        local cw = huodeZifuW()
        local keyongW = math.max(DaimaShuru.AbsoluteSize.X - BIANJU_X * 2, 40)
        local tall = celiang(qian .. "|", huanhangKai and keyongW or 100000)
        local dibu = tall and tall.Y or hangH
        local x
        if huanhangKai then
            local cols = math.max(math.floor(keyongW / cw), 1)
            x = zuihouPaiLieshu(zuihouHang, cols) * cw
        else
            x = #zuihouHang * cw
        end
        return x, math.max(dibu - hangH, 0), hangH
    end

    local function shuaxin(allowOpen)
        if not AC_QIYONG or Pop.pending or Pop.suppress then return end
        if not ZhixingqiKuangjia.Visible then return guanbiTanchuang() end
        if not DaimaShuru:IsFocused() then

            if Pop.open and (Pop.mouseOver or os.clock() - Pop.pressedAt < 0.5) then return end
            return guanbiTanchuang()
        end
        if not Pop.open and not allowOpen then return end
        huodeZifuW()

        local text = DaimaShuru.Text
        local cur = DaimaShuru.CursorPosition
        local xuanKaishi = DaimaShuru.SelectionStart
        if cur < 1 or (xuanKaishi ~= -1 and xuanKaishi ~= cur) then return guanbiTanchuang() end

        local tail = text:sub(math.max(1, cur - 200), cur - 1)
        local run = tail:match("[%w_]*$") or ""
        if run:match("^%d") then return guanbiTanchuang() end
        local ws = cur - #run
        local hou = text:sub(cur, cur + 200):match("^[%w_]*") or ""
        local we = cur - 1 + #hou

        local qianWeiba = text:sub(math.max(1, ws - 1500), ws - 1)
        local hangQian = qianWeiba:match("([^\n]*)$") or ""
        local sep = qianWeiba:sub(-1)

        local mode, base = "global", nil
        if qianWeiba:match("GetService%(%s*[\"']$") then
            mode = "service"
        else
            if zaiPinglunOrZifuchuan(hangQian) then return guanbiTanchuang() end
            if (sep == "." or sep == ":") and qianWeiba:sub(-2) ~= ".." then
                mode = "member"
                base = qianWeiba:sub(1, -2):match("([%w_]+)$")
            elseif run == "" or shiShengming(hangQian, run) then
                return guanbiTanchuang()
            end
        end

        local houxuan2
        if mode == "service" then
            houxuan2 = Fuwu
        elseif mode == "member" then
            houxuan2 = base and Chengyuan[base]
            if not houxuan2 then
                if sep == ":" then
                    houxuan2 = TONGYONG_FANGFA
                elseif run == "" then
                    return guanbiTanchuang()
                else
                    houxuan2 = TONGYONG_QUAN
                end
            end
        else
            local symbols
            if Pop.symbols and Pop.ws == ws then
                symbols = Pop.symbols
            else
                local lo, hi = math.max(1, ws - 40000), math.min(#text, we + 40000)
                symbols = saomiaoFuhao(text:sub(lo, ws - 1) .. text:sub(we + 1, hi), run)
            end
            Pop.symbols = symbols
            houxuan2 = {}
            for _, it in ipairs(Quanju) do houxuan2[#houxuan2 + 1] = it end
            for _, it in ipairs(symbols) do houxuan2[#houxuan2 + 1] = it end
        end

        local q = run:lower()
        local res = {}
        local fangfaJin = (mode == "member" and sep == ":")
        for _, c in ipairs(houxuan2) do
            if not (fangfaJin and c.k == "field") then
                if q == "" then
                    res[#res + 1] = {n = c.n, k = c.k, ins = c.ins, s = 0}
                else
                    local s, idx = mohu(c.n, q, run)
                    if s then
                        if c.doc then s += 30 elseif c.k == "keyword" then s += 10 end
                        res[#res + 1] = {n = c.n, k = c.k, ins = c.ins, s = s, idx = idx}
                    end
                end
            end
        end
        table.sort(res, function(a, b)
            if a.s ~= b.s then return a.s > b.s end
            if q ~= "" and #a.n ~= #b.n then return #a.n < #b.n end
            return a.n < b.n
        end)
        for k = #res, AC_ZUIDA_JIEGUO + 1, -1 do res[k] = nil end

        if #res == 0 or (#res == 1 and res[1].n == run) then return guanbiTanchuang() end

        local xiangtongMaodian = Pop.open and Pop.ws == ws
        Pop.items, Pop.text, Pop.ws, Pop.we, Pop.cursor, Pop.run = res, text, ws, we, cur, run
        xuanranXiang()

        Pop.token += 1
        local my = Pop.token
        if xiangtongMaodian then
            changsuoTanchuang()
        else
            task.spawn(function()
                local cx, cy, lh = guangbiaoZhibiao(text, ws)
                if my ~= Pop.token then return end
                Pop.cx, Pop.cy, Pop.lh = cx, cy, lh
                Pop.open = true
                changsuoTanchuang()
            end)
        end
    end

    local function yingyongXiang(item, text, ws, we)
        local qianWeiba = text:sub(math.max(1, ws - 400), ws - 1)
        local indent = (qianWeiba:match("([^\n]*)$") or ""):match("^%s*") or ""
        local ins = item.ins or item.n
        if item.k == "snippet" then ins = ins:gsub("\n", "\n" .. indent) end
        local at = ins:find("$0", 1, true)
        local guangbiao
        if at then
            ins = ins:sub(1, at - 1) .. ins:sub(at + 2)
            guangbiao = ws + at - 1
        else
            guangbiao = ws + #ins
        end
        local xinWenben = text:sub(1, ws - 1) .. ins .. text:sub(we + 1)
        Pop.suppress = true
        guanbiTanchuang()
        DaimaShuru.Text = xinWenben
        task.spawn(function()
            if not DaimaShuru:IsFocused() then DaimaShuru:CaptureFocus() end
            DaimaShuru.CursorPosition = guangbiao
            YunxingFuwu.Heartbeat:Wait()
            DaimaShuru.CursorPosition = guangbiao
            task.wait(0.08)
            Pop.suppress = false
        end)
    end

    jieshouAnDianji = function(i)
        local item = Pop.items[i]
        if not item then return end
        if DaimaShuru.Text ~= Pop.text then
            guanbiTanchuang()
            return
        end
        yingyongXiang(item, Pop.text, Pop.ws, Pop.we)
    end

    local function wanchengJianhaoJieshou(snap)
        local T = DaimaShuru.Text
        local c = snap.cursor
        if #T == #snap.text + 1 and T:sub(c, c) == snap.stray then
            T = T:sub(1, c - 1) .. T:sub(c + 1)
        end
        if T ~= snap.text then
            guanbiTanchuang()
            return
        end
        yingyongXiang(snap.item, T, snap.ws, snap.we)
    end

    local shuruLianjie
    shuruLianjie = YonghuShuruFuwu.InputBegan:Connect(function(input)
        if not Root.Parent then
            shuruLianjie:Disconnect()
            return
        end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        if not Pop.open or not Root.Visible or Pop.pending or not DaimaShuru:IsFocused() then return end
        if YonghuShuruFuwu:IsKeyDown(Enum.KeyCode.LeftControl) or YonghuShuruFuwu:IsKeyDown(Enum.KeyCode.RightControl) then return end
        local k = input.KeyCode

        local shiXiangka = (k == Enum.KeyCode.Tab)
        local shiJinru = (k == Enum.KeyCode.Return or k == Enum.KeyCode.KeypadEnter)
        if shiXiangka or (shiJinru and AC_JINRU_JIESHOU) then
            if shiXiangka and YonghuShuruFuwu:IsKeyDown(Enum.KeyCode.LeftShift) then return end
            local item = Pop.items[Pop.sel]
            if not item then return end

            if shiJinru and item.n == Pop.run then
                guanbiTanchuang()
                return
            end
            Pop.pending = true
            local snap = {
                item = item, text = Pop.text, ws = Pop.ws, we = Pop.we,
                cursor = Pop.cursor, stray = shiXiangka and "\t" or "\n"
            }
            task.spawn(function()
                YunxingFuwu.Heartbeat:Wait()
                YunxingFuwu.Heartbeat:Wait()
                local ok = pcall(wanchengJianhaoJieshou, snap)
                if not ok then guanbiTanchuang() end
                Pop.pending = false
            end)
        elseif k == Enum.KeyCode.Down or k == Enum.KeyCode.Up then
            local n = #Pop.items
            local xiayiXuan = Pop.sel + (k == Enum.KeyCode.Down and 1 or -1)
            if xiayiXuan < 1 then xiayiXuan = n elseif xiayiXuan > n then xiayiXuan = 1 end
            shezhiXuan(xiayiXuan, true)

            Pop.hold = os.clock() + 0.3
            local keep = Pop.cursor
            task.spawn(function()
                for _ = 1, 2 do
                    YunxingFuwu.Heartbeat:Wait()
                    if Pop.open and DaimaShuru.CursorPosition ~= keep then
                        DaimaShuru.CursorPosition = keep
                    end
                end
            end)
        elseif k == Enum.KeyCode.Escape then
            guanbiTanchuang()
        end
    end)

    local xiangDakai = false
    local shuaxinLingpai = 0
    local function anpai(allowOpen)
        if not AC_QIYONG then return end
        xiangDakai = xiangDakai or allowOpen
        shuaxinLingpai += 1
        local my = shuaxinLingpai
        task.delay(0.03, function()
            if my ~= shuaxinLingpai then return end
            local allow = xiangDakai
            xiangDakai = false
            shuaxin(allow)
        end)
    end

    DaimaShuru:GetPropertyChangedSignal("Text"):Connect(function()
        local len = #DaimaShuru.Text
        local chazhi = math.abs(len - Pop.lastLen)
        Pop.lastLen = len
        if Pop.suppress or Pop.pending then return end
        if chazhi > 2 then

            guanbiTanchuang()
            return
        end
        anpai(true)
    end)
    DaimaShuru:GetPropertyChangedSignal("CursorPosition"):Connect(function()
        if os.clock() < Pop.hold then return end
        anpai(false)
    end)
    DaimaShuru.FocusLost:Connect(function()
        task.delay(0.12, function()
            if DaimaShuru:IsFocused() then return end
            if Pop.open and (Pop.mouseOver or os.clock() - Pop.pressedAt < 0.5) then return end
            guanbiTanchuang()
        end)
    end)
    Root.MouseEnter:Connect(function() Pop.mouseOver = true end)
    Root.MouseLeave:Connect(function()
        Pop.mouseOver = false

        task.delay(0.1, function()
            if Pop.open and not Pop.mouseOver and not DaimaShuru:IsFocused() then guanbiTanchuang() end
        end)
    end)
    Root.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Pop.pressedAt = os.clock()
        end
    end)
    Gundong:GetPropertyChangedSignal("CanvasPosition"):Connect(changsuoTanchuang)
    Gundong:GetPropertyChangedSignal("AbsoluteSize"):Connect(guanbiTanchuang)
    ZhixingqiKuangjia:GetPropertyChangedSignal("Visible"):Connect(function()
        if not ZhixingqiKuangjia.Visible then guanbiTanchuang() end
    end)

    -- 语法高亮 透明输入框上面盖一层彩色文字
    local HL_QIYONG = true
    local HL_ZUIDA_ZIFU = 50000

    local HL = {
        keyword = "#569CD6",
        ident   = "#9CDCFE",
        func    = "#DCDCAA",
        string  = "#CE9178",
        number  = "#B5CEA8",
        comment = "#6A9955"
    }
    local HL_MOREN = Color3.fromRGB(212, 212, 212)

    local HL_TUICHU = {["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;", ["'"] = "&apos;"}
    local function hlTuichu(s)
        return (s:gsub("[&<>\"']", HL_TUICHU))
    end

    local function hlHang(line, st)
        local out, n = {}, 0
        local pingchang, pn = {}, 0

        local function chongshua()
            if pn > 0 then
                n += 1
                out[n] = hlTuichu(table.concat(pingchang, "", 1, pn))
                pn = 0
            end
        end
        local function put(txt, col)
            if txt == "" then return end
            chongshua()
            n += 1
            out[n] = "<font color=\"" .. col .. "\">" .. hlTuichu(txt) .. "</font>"
        end
        local function raw(txt)
            pn += 1
            pingchang[pn] = txt
        end

        local len = #line
        local i = 1

        if st ~= "" then
            local lvl = tonumber(st:sub(2)) or 0
            local col = (st:sub(1, 1) == "c") and HL.comment or HL.string
            local _, e = line:find("]" .. string.rep("=", lvl) .. "]", 1, true)
            if not e then
                put(line, col)
                return table.concat(out), st
            end
            put(line:sub(1, e), col)
            i = e + 1
            st = ""
        end

        while i <= len do
            local c = line:sub(i, i)
            if c == " " or c == "\t" then
                local ws = line:match("^[ \t]+", i)
                raw(ws)
                i += #ws

            elseif c == "-" and line:sub(i + 1, i + 1) == "-" then
                local eq = line:match("^%-%-%[(=*)%[", i)
                if eq then
                    local _, e = line:find("]" .. eq .. "]", i + 4 + #eq, true)
                    if e then
                        put(line:sub(i, e), HL.comment)
                        i = e + 1
                    else
                        put(line:sub(i), HL.comment)
                        st = "c" .. #eq
                        i = len + 1
                    end
                else
                    put(line:sub(i), HL.comment)
                    i = len + 1
                end

            elseif c == "[" and line:match("^%[=*%[", i) then
                local eq = line:match("^%[(=*)%[", i)
                local _, e = line:find("]" .. eq .. "]", i + 2 + #eq, true)
                if e then
                    put(line:sub(i, e), HL.string)
                    i = e + 1
                else
                    put(line:sub(i), HL.string)
                    st = "s" .. #eq
                    i = len + 1
                end

            elseif c == "\"" or c == "'" or c == "`" then
                local j = i + 1
                while j <= len do
                    local d = line:sub(j, j)
                    if d == "\\" then
                        j += 2
                    elseif d == c then
                        break
                    else
                        j += 1
                    end
                end
                put(line:sub(i, math.min(j, len)), HL.string)
                i = j + 1

            elseif c:match("%d") or (c == "." and line:match("^%.%d", i)) then
                local num = line:match("^0[xX]%x[%x_]*", i)
                    or line:match("^0[bB][01_]+", i)
                    or line:match("^%d[%d_]*%.?%d*[eE][+-]?%d+", i)
                    or line:match("^%d[%d_]*%.?%d*", i)
                    or line:match("^%.%d+", i)
                    or c
                put(num, HL.number)
                i += #num

            elseif c:match("[%a_]") then
                local word = line:match("^[%a_][%w_]*", i)
                local j = i + #word
                if KEYWORD_SET[word] then
                    put(word, HL.keyword)
                elseif line:match("^%s*%(", j) then
                    put(word, HL.func)
                else
                    put(word, HL.ident)
                end
                i = j

            else
                raw(c)
                i += 1
            end
        end

        chongshua()
        return table.concat(out), st
    end

    local hlFuwenben, hlZhuangtai, hlCount = {}, {}, 0
    local function gaoliangWenben(text)
        local lines = string.split(text, "\n")
        local out = table.create(#lines)
        local st = ""
        for i = 1, #lines do
            local line = lines[i]
            local key = (st == "") and line or (st .. "\1" .. line)
            local rich = hlFuwenben[key]
            if rich then
                st = hlZhuangtai[key]
            else
                local ns
                rich, ns = hlHang(line, st)
                if hlCount > 6000 then
                    hlFuwenben, hlZhuangtai, hlCount = {}, {}, 0
                end
                hlFuwenben[key], hlZhuangtai[key] = rich, ns
                hlCount += 1
                st = ns
            end
            out[i] = rich
        end
        return table.concat(out, "\n")
    end

    local HlBiaoqian = Instance.new("TextLabel")
    HlBiaoqian.Name = "SyntaxColors"
    HlBiaoqian.BackgroundTransparency = 1
    HlBiaoqian.BorderSizePixel = 0
    HlBiaoqian.Size = UDim2.new(1, 0, 1, 0)
    HlBiaoqian.RichText = true
    HlBiaoqian.Font = DaimaShuru.Font
    HlBiaoqian.TextSize = DaimaShuru.TextSize
    HlBiaoqian.TextColor3 = HL_MOREN
    HlBiaoqian.TextXAlignment = Enum.TextXAlignment.Left
    HlBiaoqian.TextYAlignment = Enum.TextYAlignment.Top
    HlBiaoqian.TextWrapped = DaimaShuru.TextWrapped
    HlBiaoqian.Text = ""
    HlBiaoqian.Visible = false
    HlBiaoqian.Parent = DaimaShuru

    local function pingchangMoshi()
        HlBiaoqian.Visible = false
        DaimaShuru.TextTransparency = 0
    end

    local function yingyongGaoliang()
        local text = DaimaShuru.Text
        if not HL_QIYONG or #text > HL_ZUIDA_ZIFU then
            pingchangMoshi()
            return
        end
        local rich = gaoliangWenben(text)
        if #rich > 180000 then
            pingchangMoshi()
            return
        end
        HlBiaoqian.Text = rich
        HlBiaoqian.Visible = true
        DaimaShuru.TextTransparency = 1
    end

    local function anquanGaoliang()
        local ok = pcall(yingyongGaoliang)
        if not ok then pingchangMoshi() end
    end

    DaimaShuru:GetPropertyChangedSignal("Text"):Connect(anquanGaoliang)
    DaimaShuru:GetPropertyChangedSignal("TextWrapped"):Connect(function()
        HlBiaoqian.TextWrapped = DaimaShuru.TextWrapped
    end)
    DaimaShuru:GetPropertyChangedSignal("TextSize"):Connect(function()
        HlBiaoqian.TextSize = DaimaShuru.TextSize
    end)
    anquanGaoliang()

    local zuihouXiangka = dangqianDaoyanXiangka()
    DaimaShuru:GetPropertyChangedSignal("Text"):Connect(function()
        local now = dangqianDaoyanXiangka()
        if now ~= zuihouXiangka then
            zuihouXiangka = now
            Gundong.CanvasPosition = Vector2.new(0, 0)
        end
        duilieDaoyanZidongcun()
        gengxinTongji()
        shuaxinHanghao()
        gensuiZhizhen()
    end)
    DaimaShuru:GetPropertyChangedSignal("CursorPosition"):Connect(function()
        if DaoyanZhuangtai.AC and DaoyanZhuangtai.AC.Holding() then return end
        gengxinTongji()
        gensuiZhizhen()
    end)

    DaimaShuru.Focused:Connect(function()
        Tween(WaikeMiaobian, 0.15, {Color = Yanse.White, Transparency = 0.1})
    end)
    DaimaShuru.FocusLost:Connect(function()
        Tween(WaikeMiaobian, 0.15, {Color = Yanse.Border, Transparency = 0.2})
    end)

    Gundong:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        tongbuZuixiaoDaxiao()
        shuaxinHanghao()
    end)
    DaimaShuru:GetPropertyChangedSignal("TextSize"):Connect(shuaxinHanghao)
    ZhixingqiKuangjia:GetPropertyChangedSignal("Visible"):Connect(function()
        if ZhixingqiKuangjia.Visible then
            task.defer(function()
                tongbuZuixiaoDaxiao()
                shuaxinHanghao()
            end)
        end
    end)

    yingyongHuanhang(Shezhi.DirectorWrap ~= false)
    gengxinTongji()
    tuseZt()
    shuaxinDaoyanXiangkaAnniu()
end)()

local MingdanKuangjia = Instance.new("Frame")
local MingdanDaN
do
    MingdanKuangjia.Name = "CreditsFrame"
    MingdanKuangjia.Size = UDim2.new(1, 0, 1, -52)
    MingdanKuangjia.Position = UDim2.new(0, 0, 0, 52)
    MingdanKuangjia.BackgroundTransparency = 1
    MingdanKuangjia.Visible = false
    MingdanKuangjia.Parent = ZhuKuangjia

    local MingdanNeirong = Instance.new("Frame")
    MingdanNeirong.Name = "CreditsContent"
    MingdanNeirong.Size = UDim2.new(1, -36, 1, -24)
    MingdanNeirong.Position = UDim2.new(0, 18, 0, 12)
    MingdanNeirong.BackgroundTransparency = 1
    MingdanNeirong.Parent = MingdanKuangjia

    local MingdanLogo = Instance.new("ImageLabel")
    MingdanLogo.Size = UDim2.new(0, 120, 0, 120)
    MingdanLogo.Position = UDim2.new(0.5, -60, 0.05, 0)
    MingdanLogo.BackgroundTransparency = 1
    MingdanLogo.Parent = MingdanNeirong
    JiazaiTupianYibu(MingdanLogo, TUPIAN_URLS.IntroLogo)

    MingdanDaN = Instance.new("TextLabel")
    MingdanDaN.Size = UDim2.new(1, 0, 0, 60)
    MingdanDaN.Position = UDim2.new(0, 0, 0.05, 120)
    MingdanDaN.BackgroundTransparency = 1
    MingdanDaN.Text = "AN UNIVERSAL"
    MingdanDaN.TextColor3 = Yanse.BrandRed
    MingdanDaN.Font = Ziti.Heavy
    MingdanDaN.TextSize = 48
    MingdanDaN.Parent = MingdanNeirong

    local ZuozheBiaoti = Instance.new("TextLabel")
    ZuozheBiaoti.Size = UDim2.new(1, 0, 0, 30)
    ZuozheBiaoti.Position = UDim2.new(0, 0, 0.05, 180)
    ZuozheBiaoti.BackgroundTransparency = 1
    ZuozheBiaoti.Text = "Created by: noli_0"
    ZuozheBiaoti.TextColor3 = Yanse.White
    ZuozheBiaoti.Font = Ziti.Bold
    ZuozheBiaoti.TextSize = 18
    ZuozheBiaoti.Parent = MingdanNeirong

    local CoChuangshirenBiaoti = Instance.new("TextLabel")
    CoChuangshirenBiaoti.Size = UDim2.new(1, 0, 0, 30)
    CoChuangshirenBiaoti.Position = UDim2.new(0, 0, 0.05, 210)
    CoChuangshirenBiaoti.BackgroundTransparency = 1
    CoChuangshirenBiaoti.Text = "Co-Founder: thats_carvs"
    CoChuangshirenBiaoti.TextColor3 = Yanse.White
    CoChuangshirenBiaoti.Font = Ziti.Bold
    CoChuangshirenBiaoti.TextSize = 16
    CoChuangshirenBiaoti.Parent = MingdanNeirong

    local MingdanMiaoshu = Instance.new("TextLabel")
    MingdanMiaoshu.Size = UDim2.new(1, 0, 0, 40)
    MingdanMiaoshu.Position = UDim2.new(0, 0, 0.05, 250)
    MingdanMiaoshu.BackgroundTransparency = 1
    MingdanMiaoshu.Text = "Everything is created with blood sweat and tears twim"
    MingdanMiaoshu.TextColor3 = Yanse.GreyMuted
    MingdanMiaoshu.Font = Ziti.Medium
    MingdanMiaoshu.TextSize = 13
    MingdanMiaoshu.Parent = MingdanNeirong
end

local GuanliKuangjia
local GuanliDaimaShuru
local WanjiaGundong

if ShiGuanli(LocalPlayer.UserId) then
    GuanliKuangjia = Instance.new("Frame")
    GuanliKuangjia.Name = "AdminFrame"
    GuanliKuangjia.Size = UDim2.new(1, 0, 1, -52)
    GuanliKuangjia.Position = UDim2.new(0, 0, 0, 52)
    GuanliKuangjia.BackgroundTransparency = 1
    GuanliKuangjia.Visible = false
    GuanliKuangjia.Parent = ZhuKuangjia

    local GuanliZhengwen = Instance.new("Frame")
    GuanliZhengwen.Size = UDim2.new(1, -36, 1, -24)
    GuanliZhengwen.Position = UDim2.new(0, 18, 0, 12)
    GuanliZhengwen.BackgroundTransparency = 1
    GuanliZhengwen.Parent = GuanliKuangjia

    local ZuoMianban = Instance.new("Frame")
    ZuoMianban.Size = UDim2.new(0.48, 0, 1, -55)
    ZuoMianban.Position = UDim2.new(0, 0, 0, 0)
    ZuoMianban.BackgroundTransparency = 1
    ZuoMianban.Parent = GuanliZhengwen

    local MinglingBiaoti = Instance.new("TextLabel")
    MinglingBiaoti.Size = UDim2.new(1, 0, 0, 20)
    MinglingBiaoti.BackgroundTransparency = 1
    MinglingBiaoti.Text = "Command List"
    MinglingBiaoti.Font = Ziti.Bold
    MinglingBiaoti.TextSize = 14
    MinglingBiaoti.TextColor3 = Yanse.White
    MinglingBiaoti.TextXAlignment = Enum.TextXAlignment.Left
    MinglingBiaoti.Parent = ZuoMianban

    local MinglingGundong = Instance.new("ScrollingFrame")
    MinglingGundong.Size = UDim2.new(1, 0, 1, -25)
    MinglingGundong.Position = UDim2.new(0, 0, 0, 25)
    MinglingGundong.BackgroundColor3 = Yanse.DarkCard
    MinglingGundong.BorderSizePixel = 0
    MinglingGundong.ScrollBarThickness = 4
    MinglingGundong.ScrollBarImageColor3 = Yanse.BrandRed
    MinglingGundong.Parent = ZuoMianban
    chuangjianYuanjiao(MinglingGundong, 6)
    chuangjianMiaobian(MinglingGundong, Yanse.Border, 1)

    local CBuju = Instance.new("UIListLayout")
    CBuju.Padding = UDim.new(0, 5)
    CBuju.SortOrder = Enum.SortOrder.LayoutOrder
    CBuju.Parent = MinglingGundong

    local CBianju = Instance.new("UIPadding")
    CBianju.PaddingTop = UDim.new(0, 5)
    CBianju.PaddingLeft = UDim.new(0, 5)
    CBianju.PaddingRight = UDim.new(0, 5)
    CBianju.PaddingBottom = UDim.new(0, 5)
    CBianju.Parent = MinglingGundong

    CBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        MinglingGundong.CanvasSize = UDim2.new(0, 0, 0, CBuju.AbsoluteContentSize.Y + 10)
    end)

    local cmds = {
        "/Kill [name/all]",
        "/Kick [name/all]",
        "/Bring [name/all]",
        "/Fling [name/all]",
        "/Loopkill [name/all]",
        "/Unloopkill [name/all]",
        "/Explode [name/all]",
        "/Spin [name/all]",
        "/Unspin [name/all]",
        "/Freeze [name/all]",
        "/Thaw [name/all]",
        "/Jump [name/all]",
        "/Sit [name/all]",
        "/Speed [name/all] [val]",
        "/ban [name] [reason] [duration]",
        "/unban [name]"
    }

    for _, cmdStr in ipairs(cmds) do
        local cLbl = Instance.new("TextLabel")
        cLbl.Size = UDim2.new(1, -5, 0, 30)
        cLbl.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        cLbl.Text = " " .. cmdStr
        cLbl.TextColor3 = Yanse.GreyLight
        cLbl.Font = Ziti.Medium
        cLbl.TextSize = 12
        cLbl.TextXAlignment = Enum.TextXAlignment.Left
        cLbl.Parent = MinglingGundong
        chuangjianYuanjiao(cLbl, 4)
        chuangjianMiaobian(cLbl, Yanse.Border, 1, 0.5)
    end

    local YouMianban = Instance.new("Frame")
    YouMianban.Size = UDim2.new(0.48, 0, 1, -55)
    YouMianban.Position = UDim2.new(0.52, 0, 0, 0)
    YouMianban.BackgroundTransparency = 1
    YouMianban.Parent = GuanliZhengwen

    local WanjiaBiaoti = Instance.new("TextLabel")
    WanjiaBiaoti.Size = UDim2.new(1, 0, 0, 20)
    WanjiaBiaoti.BackgroundTransparency = 1
    WanjiaBiaoti.Text = "Active Users (Click to copy ID)"
    WanjiaBiaoti.Font = Ziti.Bold
    WanjiaBiaoti.TextSize = 14
    WanjiaBiaoti.TextColor3 = Yanse.BrandRed
    WanjiaBiaoti.TextXAlignment = Enum.TextXAlignment.Left
    WanjiaBiaoti.Parent = YouMianban

    WanjiaGundong = Instance.new("ScrollingFrame")
    WanjiaGundong.Size = UDim2.new(1, 0, 1, -25)
    WanjiaGundong.Position = UDim2.new(0, 0, 0, 25)
    WanjiaGundong.BackgroundColor3 = Yanse.DarkCard
    WanjiaGundong.BorderSizePixel = 0
    WanjiaGundong.ScrollBarThickness = 4
    WanjiaGundong.ScrollBarImageColor3 = Yanse.BrandRed
    WanjiaGundong.Parent = YouMianban
    chuangjianYuanjiao(WanjiaGundong, 6)
    chuangjianMiaobian(WanjiaGundong, Yanse.Border, 1)

    local PBuju = Instance.new("UIListLayout")
    PBuju.Padding = UDim.new(0, 5)
    PBuju.SortOrder = Enum.SortOrder.LayoutOrder
    PBuju.Parent = WanjiaGundong

    local PBianju = Instance.new("UIPadding")
    PBianju.PaddingTop = UDim.new(0, 5)
    PBianju.PaddingLeft = UDim.new(0, 5)
    PBianju.PaddingRight = UDim.new(0, 5)
    PBianju.PaddingBottom = UDim.new(0, 5)
    PBianju.Parent = WanjiaGundong

    PBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        WanjiaGundong.CanvasSize = UDim2.new(0, 0, 0, PBuju.AbsoluteContentSize.Y + 10)
    end)

    GuanliDaimaShuru = Instance.new("TextBox")
    GuanliDaimaShuru.Size = UDim2.new(1, 0, 0, 45)
    GuanliDaimaShuru.Position = UDim2.new(0, 0, 1, -45)
    GuanliDaimaShuru.BackgroundColor3 = Yanse.DarkCard
    GuanliDaimaShuru.Text = ""
    GuanliDaimaShuru.PlaceholderText = "Enter command here and hit enter..."
    GuanliDaimaShuru.TextColor3 = Yanse.White
    GuanliDaimaShuru.Font = Ziti.Medium
    GuanliDaimaShuru.TextSize = 15
    GuanliDaimaShuru.TextXAlignment = Enum.TextXAlignment.Left
    GuanliDaimaShuru.ClearTextOnFocus = true
    GuanliDaimaShuru.Parent = GuanliZhengwen
    chuangjianYuanjiao(GuanliDaimaShuru, 6)
    chuangjianMiaobian(GuanliDaimaShuru, Yanse.Border, 1)

    local GuanliBianju = Instance.new("UIPadding")
    GuanliBianju.PaddingTop = UDim.new(0, 10)
    GuanliBianju.PaddingLeft = UDim.new(0, 10)
    GuanliBianju.PaddingRight = UDim.new(0, 10)
    GuanliBianju.PaddingBottom = UDim.new(0, 10)
    GuanliBianju.Parent = GuanliDaimaShuru

    GuanliDaimaShuru.FocusLost:Connect(function(enterPressed)
        if enterPressed and GuanliDaimaShuru.Text ~= "" then
            local text = GuanliDaimaShuru.Text
            local TextChatService = game:GetService("TextChatService")
            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                TextChatService.TextChannels.RBXGeneral:SendAsync(text)
            else
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
            end
            GuanliDaimaShuru.Text = ""
        end
    end)
end

-- 管理员指令只作用在自己身上
local function ZhixingMinglingTexiao(speaker, targetPlayer, cmd, args)
    if targetPlayer ~= LocalPlayer then return end
    if cmd == "/kill" then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Health = 0
        end
    elseif cmd == "/kick" then
        LocalPlayer:Kick("You have been kicked by an AN Administrator.")
    elseif cmd == "/bring" then
        if speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = speaker.Character.HumanoidRootPart.CFrame
        end
    elseif cmd == "/fling" then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Velocity = Vector3.new(math.random(-10000, 10000), 10000, math.random(-10000, 10000))
            bv.Parent = hrp
            task.delay(0.5, function() bv:Destroy() end)
        end
    elseif cmd == "/loopkill" then
        XunhuanJishaMubiao[LocalPlayer.UserId] = not XunhuanJishaMubiao[LocalPlayer.UserId]
    elseif cmd == "/explode" then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local exp = Instance.new("Explosion")
            exp.Position = LocalPlayer.Character.HumanoidRootPart.Position
            exp.Parent = workspace
            if LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.Health = 0
            end
        end
    elseif cmd == "/spin" then
        XuanzhuanMubiao[LocalPlayer.UserId] = not XuanzhuanMubiao[LocalPlayer.UserId]
    elseif cmd == "/freeze" then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Anchored = true
            chuangjianBingFangkuai(LocalPlayer.Character)
        end
    elseif cmd == "/thaw" then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Anchored = false
            yichuBingFangkuai()
        end
    elseif cmd == "/unspin" then
        XuanzhuanMubiao[LocalPlayer.UserId] = nil
    elseif cmd == "/unloopkill" then
        XunhuanJishaMubiao[LocalPlayer.UserId] = nil
    elseif cmd == "/jump" then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Jump = true
        end
    elseif cmd == "/sit" then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Sit = true
        end
    elseif cmd == "/speed" then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(args[3]) or 16
        end
    end
end

local function ZhanshiMinglingQingqiuTongzhi(requesterPlayer, cmd, args)
    local TongzhiKuangjia = Instance.new("Frame")
    TongzhiKuangjia.Size = UDim2.new(0, 360, 0, 115)
    TongzhiKuangjia.Position = UDim2.new(0.5, -180, 0, -130)
    TongzhiKuangjia.BackgroundColor3 = Yanse.DarkBack
    TongzhiKuangjia.BorderSizePixel = 0
    TongzhiKuangjia.ZIndex = 300
    TongzhiKuangjia.Parent = PingmuJiemian
    chuangjianYuanjiao(TongzhiKuangjia, 8)
    chuangjianMiaobian(TongzhiKuangjia, Yanse.BrandRed, 2)

    local BiaotiBq = Instance.new("TextLabel")
    BiaotiBq.Size = UDim2.new(1, -40, 0, 26)
    BiaotiBq.Position = UDim2.new(0, 12, 0, 6)
    BiaotiBq.BackgroundTransparency = 1
    BiaotiBq.Text = "⚠️ COMMAND PERMISSION REQUEST"
    BiaotiBq.TextColor3 = Yanse.BrandRed
    BiaotiBq.Font = Ziti.Heavy
    BiaotiBq.TextSize = 13
    BiaotiBq.TextXAlignment = Enum.TextXAlignment.Left
    BiaotiBq.ZIndex = 301
    BiaotiBq.Parent = TongzhiKuangjia

    local GuanbiBtn = Instance.new("TextButton")
    GuanbiBtn.Size = UDim2.new(0, 24, 0, 24)
    GuanbiBtn.Position = UDim2.new(1, -30, 0, 6)
    GuanbiBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    GuanbiBtn.Text = "×"
    GuanbiBtn.TextColor3 = Yanse.White
    GuanbiBtn.Font = Ziti.Bold
    GuanbiBtn.TextSize = 16
    GuanbiBtn.ZIndex = 301
    GuanbiBtn.Parent = TongzhiKuangjia
    chuangjianYuanjiao(GuanbiBtn, 12)
    BangdingJiaohuShengyin(GuanbiBtn)

    local MiaoshuBq = Instance.new("TextLabel")
    MiaoshuBq.Size = UDim2.new(1, -24, 0, 32)
    MiaoshuBq.Position = UDim2.new(0, 12, 0, 32)
    MiaoshuBq.BackgroundTransparency = 1
    MiaoshuBq.Text = string.format("%s (@%s) asks if they can %s you", requesterPlayer.DisplayName, requesterPlayer.Name, cmd)
    MiaoshuBq.TextColor3 = Yanse.White
    MiaoshuBq.Font = Ziti.Medium
    MiaoshuBq.TextSize = 12
    MiaoshuBq.TextXAlignment = Enum.TextXAlignment.Left
    MiaoshuBq.TextWrapped = true
    MiaoshuBq.ZIndex = 301
    MiaoshuBq.Parent = TongzhiKuangjia

    local JieshouBtn = Instance.new("TextButton")
    JieshouBtn.Size = UDim2.new(0.45, 0, 0, 30)
    JieshouBtn.Position = UDim2.new(0, 12, 0, 70)
    JieshouBtn.BackgroundColor3 = Color3.fromRGB(46, 125, 50)
    JieshouBtn.Text = "Accept"
    JieshouBtn.TextColor3 = Yanse.White
    JieshouBtn.Font = Ziti.Bold
    JieshouBtn.TextSize = 12
    JieshouBtn.ZIndex = 301
    JieshouBtn.Parent = TongzhiKuangjia
    chuangjianYuanjiao(JieshouBtn, 4)
    BangdingJiaohuShengyin(JieshouBtn)

    local JuBtn = Instance.new("TextButton")
    JuBtn.Size = UDim2.new(0.45, 0, 0, 30)
    JuBtn.Position = UDim2.new(0.5, 5, 0, 70)
    JuBtn.BackgroundColor3 = Color3.fromRGB(198, 40, 40)
    JuBtn.Text = "Reject"
    JuBtn.TextColor3 = Yanse.White
    JuBtn.Font = Ziti.Bold
    JuBtn.TextSize = 12
    JuBtn.ZIndex = 301
    JuBtn.Parent = TongzhiKuangjia
    chuangjianYuanjiao(JuBtn, 4)
    BangdingJiaohuShengyin(JuBtn)

    local TiaoBeijing = Instance.new("Frame")
    TiaoBeijing.Size = UDim2.new(1, 0, 0, 4)
    TiaoBeijing.Position = UDim2.new(0, 0, 1, -4)
    TiaoBeijing.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TiaoBeijing.BorderSizePixel = 0
    TiaoBeijing.ZIndex = 301
    TiaoBeijing.Parent = TongzhiKuangjia

    local TiaoTianchong = Instance.new("Frame")
    TiaoTianchong.Size = UDim2.new(1, 0, 1, 0)
    TiaoTianchong.BackgroundColor3 = Yanse.BrandRed
    TiaoTianchong.BorderSizePixel = 0
    TiaoTianchong.ZIndex = 302
    TiaoTianchong.Parent = TiaoBeijing

    BofangShengyinYibu(SHENGYIN_URLS.Intro, "Intro", 0.6)

    DonghuaFuwu:Create(TongzhiKuangjia, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -180, 0, 20)
    }):Play()

    local shichang = 12
    local xiaohaoDonghua = DonghuaFuwu:Create(TiaoTianchong, TweenInfo.new(shichang, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 1, 0)
    })
    xiaohaoDonghua:Play()

    local shiYiguan = false
    local function guanbiTongzhi()
        if shiYiguan then return end
        shiYiguan = true
        xiaohaoDonghua:Cancel()
        local chuDonghua = DonghuaFuwu:Create(TongzhiKuangjia, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -180, 0, -130)
        })
        chuDonghua:Play()
        chuDonghua.Completed:Wait()
        if TongzhiKuangjia then TongzhiKuangjia:Destroy() end
    end

    GuanbiBtn.MouseButton1Click:Connect(guanbiTongzhi)
    JuBtn.MouseButton1Click:Connect(guanbiTongzhi)
    JieshouBtn.MouseButton1Click:Connect(function()
        ZhixingMinglingTexiao(requesterPlayer, LocalPlayer, cmd, args)
        guanbiTongzhi()
    end)

    task.delay(shichang, function()
        if not shiYiguan then
            guanbiTongzhi()
        end
    end)
end

-- 聊天指令解析
local function ChuliGuanliMingling(speaker, message)
    if not ShiGuanli(speaker.UserId) then return end

    local args = string.split(message, " ")
    local cmd = string.lower(args[1])
    local mubiaoZifuchuan = args[2]

    if cmd == "/ban" then
        if HuodeYonghuDengji(speaker.UserId) < 2 then return end
        local mubiaoMingzi = args[2]
        if not mubiaoMingzi then return end

        local shichangZifuchuan = args[#args]
        local yuanyinCanshu = {}

        for i = 3, #args - 1 do
            table.insert(yuanyinCanshu, args[i])
        end

        local yuanyinZifuchuan = table.concat(yuanyinCanshu, " ")
        if yuanyinZifuchuan == "" then yuanyinZifuchuan = "Banned via Admin Panel" end

        local mubiaoYonghuId
        for _, p in ipairs(Wanjia:GetPlayers()) do
            if string.lower(p.Name) == string.lower(mubiaoMingzi) or string.lower(p.DisplayName) == string.lower(mubiaoMingzi) then
                mubiaoYonghuId = p.UserId
                break
            end
        end

        if not mubiaoYonghuId then
            pcall(function()
                mubiaoYonghuId = Wanjia:GetUserIdFromNameAsync(mubiaoMingzi)
            end)
        end

        if mubiaoYonghuId then
            if HuodeYonghuDengji(speaker.UserId) <= HuodeYonghuDengji(mubiaoYonghuId) and HuodeYonghuDengji(speaker.UserId) < 4 then return end
            local changdu = fenxiShichang(shichangZifuchuan)
            local guoqiShijian = (changdu == -1) and -1 or (os.time() + changdu)
            local zaihe = HttpFuwu:JSONEncode({
                expires = guoqiShijian,
                banned_by = speaker.Name,
                reason = yuanyinZifuchuan,
                username = mubiaoMingzi
            })

            task.spawn(function()
                if httpQingqiu then
                    httpQingqiu({
                        Url = JICHU_URL .. "blacklist/" .. mubiaoYonghuId .. ".json",
                        Method = "PUT",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = zaihe
                    })
                    print("AN Hub: Successfully banned User ID " .. mubiaoYonghuId)
                end
            end)

            for _, p in ipairs(Wanjia:GetPlayers()) do
                if p.UserId == mubiaoYonghuId then
                    p:Kick("You have been banned.\nReason: " .. yuanyinZifuchuan)
                end
            end
        else
            warn("AN Hub: Could not resolve username to UserId.")
        end
        return
    end

    if cmd == "/unban" then
        if HuodeYonghuDengji(speaker.UserId) < 2 then return end
        local mubiaoMingzi = args[2]
        if not mubiaoMingzi then return end

        local mubiaoYonghuId
        pcall(function()
            mubiaoYonghuId = Wanjia:GetUserIdFromNameAsync(mubiaoMingzi)
        end)

        if mubiaoYonghuId then
            task.spawn(function()
                if httpQingqiu then
                    httpQingqiu({
                        Url = JICHU_URL .. "blacklist/" .. mubiaoYonghuId .. ".json",
                        Method = "DELETE"
                    })
                    print("AN Hub: Successfully unbanned User ID " .. mubiaoYonghuId)
                end
            end)
        end
        return
    end

    if mubiaoZifuchuan then
        local fayanzheDengji = HuodeYonghuDengji(speaker.UserId)
        local mubiaoWanjia = {}

        if string.lower(mubiaoZifuchuan) == "all" then
            for _, p in ipairs(Wanjia:GetPlayers()) do
                table.insert(mubiaoWanjia, p)
            end
        else
            for _, p in ipairs(Wanjia:GetPlayers()) do
                local pMingzi = string.lower(p.Name)
                local pXianshi = string.lower(p.DisplayName)
                local tStr = string.lower(mubiaoZifuchuan)
                if string.sub(pMingzi, 1, #tStr) == tStr or string.sub(pXianshi, 1, #tStr) == tStr then
                    table.insert(mubiaoWanjia, p)
                end
            end
        end

        for _, targetPlayer in ipairs(mubiaoWanjia) do
            local mubiaoDengji = HuodeYonghuDengji(targetPlayer.UserId)
            if fayanzheDengji == 4 or fayanzheDengji >= mubiaoDengji then
                ZhixingMinglingTexiao(speaker, targetPlayer, cmd, args)
            else
                if targetPlayer == LocalPlayer then
                    ZhanshiMinglingQingqiuTongzhi(speaker, cmd, args)
                end
            end
        end
    end
end

for _, p in ipairs(Wanjia:GetPlayers()) do
    p.Chatted:Connect(function(msg) ChuliGuanliMingling(p, msg) end)
end
Wanjia.PlayerAdded:Connect(function(p)
    p.Chatted:Connect(function(msg) ChuliGuanliMingling(p, msg) end)
end)

-- 设置页
local ShezhiKuangjia = Instance.new("Frame")
local ShezhiGundong = Instance.new("ScrollingFrame")
local ShezhiBuju = Instance.new("UIListLayout")
local FankuiShuru = Instance.new("TextBox")
local FankuiTijiaoBtn = Instance.new("TextButton")
local BiaozhiQiehuanBtn
local JiaruIdKuang = Instance.new("TextBox")
local ShiliuShuru = Instance.new("TextBox")
local gengxinToudingKejian

do

    local SUI = {sw = {}, syncs = {}, swatches = {}, card = {}}
    AN_HUANJING.AN_SettingsUI = SUI

    SUI.btnH = shiShouji2() and 40 or 32
    SUI.narrow = ZhuKuangjia.Size.X.Offset < 560
    SUI.hoverRow = Color3.fromRGB(32, 32, 32)
    SUI.fieldBg = Color3.fromRGB(15, 15, 15)
    SUI.neutral = Color3.fromRGB(44, 44, 44)
    SUI.neutralHover = Color3.fromRGB(60, 60, 60)
    SUI.offTrack = Color3.fromRGB(62, 62, 62)
    SUI.dangerText = Color3.fromRGB(235, 130, 130)

    function SUI.make(class, props, parent)
        local o = Instance.new(class)
        for k, v in pairs(props) do o[k] = v end
        if parent then o.Parent = parent end
        return o
    end

    function SUI.text(parent, text, font, size, color, pos, siz)
        return SUI.make("TextLabel", {
            BackgroundTransparency = 1, Text = text, Font = font, TextSize = size, TextColor3 = color,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
            TextTruncate = Enum.TextTruncate.AtEnd, Position = pos, Size = siz
        }, parent)
    end

    function SUI.tween(obj, t, props)
        DonghuaFuwu:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
    end

    function SUI.pad(parent, t, r, b, l)
        return SUI.make("UIPadding", {
            PaddingTop = UDim.new(0, t), PaddingRight = UDim.new(0, r),
            PaddingBottom = UDim.new(0, b), PaddingLeft = UDim.new(0, l)
        }, parent)
    end

    function SUI.flash(btn, text, dur)
        local orig = btn:GetAttribute("OrigText") or btn.Text
        btn:SetAttribute("OrigText", orig)
        btn.Text = text
        task.delay(dur or 1.4, function()
            if btn.Parent then btn.Text = orig end
        end)
    end

    ShezhiKuangjia.Name = "SettingsFrame"
    ShezhiKuangjia.Size = UDim2.new(1, 0, 1, -52)
    ShezhiKuangjia.Position = UDim2.new(0, 0, 0, 52)
    ShezhiKuangjia.BackgroundTransparency = 1
    ShezhiKuangjia.Visible = false
    ShezhiKuangjia.Parent = ZhuKuangjia

    ShezhiGundong.Name = "SettingsScroll"
    ShezhiGundong.Size = UDim2.new(1, 0, 1, 0)
    ShezhiGundong.Position = UDim2.new(0, 0, 0, 0)
    ShezhiGundong.BackgroundTransparency = 1
    ShezhiGundong.BorderSizePixel = 0
    ShezhiGundong.ScrollBarThickness = 4
    ShezhiGundong.ScrollBarImageColor3 = Yanse.BrandRed
    ShezhiGundong.ScrollingDirection = Enum.ScrollingDirection.Y
    ShezhiGundong.CanvasSize = UDim2.new(0, 0, 0, 0)
    ShezhiGundong.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ShezhiGundong.Parent = ShezhiKuangjia
    if SUI.narrow then SUI.pad(ShezhiGundong, 12, 12, 20, 12) else SUI.pad(ShezhiGundong, 18, 20, 28, 18) end

    ShezhiBuju.SortOrder = Enum.SortOrder.LayoutOrder
    ShezhiBuju.Padding = UDim.new(0, 18)
    ShezhiBuju.Parent = ShezhiGundong

    function SUI.section(title, order)
        local wrap = SUI.make("Frame", {
            Name = "Section_" .. title, BackgroundTransparency = 1, LayoutOrder = order,
            Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y
        }, ShezhiGundong)
        SUI.make("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8)}, wrap)
        local head = SUI.text(wrap, string.upper(title), Ziti.Bold, 11, Yanse.GreyMuted, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 14))
        head.LayoutOrder = 1
        SUI.pad(head, 0, 0, 0, 4)
        local card = SUI.make("Frame", {
            Name = "Card", BackgroundColor3 = Yanse.DarkCard, BorderSizePixel = 0, ClipsDescendants = true,
            LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y
        }, wrap)
        chuangjianYuanjiao(card, 8)
        chuangjianMiaobian(card, Yanse.Border, 1, 0.4)
        SUI.make("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}, card)
        SUI.card[title] = card
        return card
    end

    function SUI.row(card, title, desc, opts)
        opts = opts or {}
        local n = (card:GetAttribute("n") or 0) + 1
        card:SetAttribute("n", n)
        local duidie = opts.stack and SUI.narrow
        local h = opts.height or (duidie and (58 + SUI.btnH + 14) or 62)
        local row = SUI.make(opts.clickable and "TextButton" or "Frame", {
            Name = "Row", LayoutOrder = n, BorderSizePixel = 0,
            BackgroundColor3 = SUI.hoverRow, BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, h)
        }, card)
        if opts.clickable then
            row.Text = ""
            row.AutoButtonColor = false
            row.MouseEnter:Connect(function() SUI.tween(row, 0.12, {BackgroundTransparency = 0}) end)
            row.MouseLeave:Connect(function() SUI.tween(row, 0.12, {BackgroundTransparency = 1}) end)
            BangdingJiaohuShengyin(row)
        end
        if n > 1 then
            SUI.make("Frame", {
                Name = "Divider", BackgroundColor3 = Yanse.Border, BackgroundTransparency = 0.25,
                BorderSizePixel = 0, Position = UDim2.new(0, 16, 0, 0), Size = UDim2.new(1, -32, 0, 1)
            }, row)
        end
        local baoliu = (duidie or opts.noControls) and 32 or ((opts.ctrlW or 150) + 40)
        SUI.text(row, title, Ziti.Bold, 14, Yanse.White, UDim2.new(0, 16, 0, desc and 12 or (h - 18) / 2), UDim2.new(1, -baoliu, 0, 18))
        if desc then
            local d = SUI.text(row, desc, Ziti.Book, 12, Yanse.GreyMuted, UDim2.new(0, 16, 0, 32), UDim2.new(1, -baoliu, 0, 16))
            if opts.noControls then

                d.TextWrapped = true
                d.TextTruncate = Enum.TextTruncate.None
                d.TextYAlignment = Enum.TextYAlignment.Top
                d.Size = UDim2.new(1, -baoliu, 0, 30)
            end
        end
        if opts.noControls then return row end

        local ctl = SUI.make("Frame", {Name = "Controls", BackgroundTransparency = 1}, row)
        if duidie then
            ctl.Position = UDim2.new(0, 16, 0, 58)
            ctl.Size = UDim2.new(1, -32, 0, SUI.btnH)
        else
            ctl.AnchorPoint = Vector2.new(1, 0.5)
            ctl.Position = UDim2.new(1, -16, 0.5, 0)
            ctl.Size = UDim2.new(0, opts.ctrlW or 150, 0, SUI.btnH)
        end
        SUI.make("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        }, ctl)
        return row, ctl
    end

    function SUI.button(parent, text, kind, w, existing)
        kind = kind or "default"
        local btn = existing or Instance.new("TextButton")
        btn.Text = text
        btn.Font = Ziti.Bold
        btn.TextSize = 12
        btn.AutoButtonColor = false
        btn.BorderSizePixel = 0
        btn.Size = UDim2.new(0, w or 88, 0, SUI.btnH)
        local function rest()
            if kind == "primary" then return Yanse.BrandRed end
            if kind == "danger" then return Color3.fromRGB(46, 30, 30) end
            return SUI.neutral
        end
        local function xuanting()
            if kind == "primary" then return Yanse.BrandRed:Lerp(Color3.new(1, 1, 1), 0.15) end
            if kind == "danger" then return Color3.fromRGB(70, 34, 34) end
            return SUI.neutralHover
        end
        btn.BackgroundColor3 = rest()
        btn.TextColor3 = (kind == "danger") and SUI.dangerText or Yanse.White
        btn.Parent = parent
        chuangjianYuanjiao(btn, 6)
        if kind ~= "primary" then
            chuangjianMiaobian(btn, kind == "danger" and Color3.fromRGB(90, 44, 44) or Color3.fromRGB(58, 58, 58), 1, 0)
        end
        BangdingJiaohuShengyin(btn)

        local function dongjie() return btn.Text == "Locked" or btn.Text == "Sent!" end
        btn.MouseEnter:Connect(function()
            if not dongjie() then SUI.tween(btn, 0.12, {BackgroundColor3 = xuanting()}) end
        end)
        btn.MouseLeave:Connect(function()
            if not dongjie() then SUI.tween(btn, 0.12, {BackgroundColor3 = rest()}) end
        end)
        return btn
    end

    function SUI.field(box, w)
        box.BackgroundColor3 = SUI.fieldBg
        box.BorderSizePixel = 0
        box.Font = Ziti.Medium
        box.TextSize = 12
        box.TextColor3 = Yanse.White
        box.PlaceholderColor3 = Yanse.GreyMuted
        box.ClearTextOnFocus = false
        if w then box.Size = w end
        chuangjianYuanjiao(box, 6)
        local miaobian = chuangjianMiaobian(box, Yanse.Border, 1, 0)
        box.Focused:Connect(function() SUI.tween(miaobian, 0.12, {Color = Yanse.BrandRed}) end)
        box.FocusLost:Connect(function() SUI.tween(miaobian, 0.12, {Color = Yanse.Border}) end)
        return miaobian
    end

    function SUI.switchRow(card, title, desc, initial)
        local btn = SUI.row(card, title, desc, {clickable = true, ctrlW = 96})
        local track = SUI.make("Frame", {
            Name = "Track", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -16, 0.5, 0),
            Size = UDim2.new(0, 44, 0, 24), BorderSizePixel = 0,
            BackgroundColor3 = initial and Yanse.BrandRed or SUI.offTrack
        }, btn)
        chuangjianYuanjiao(track, 12)
        local knob = SUI.make("Frame", {
            Name = "Knob", AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.new(0, 18, 0, 18),
            BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1),
            Position = initial and UDim2.new(1, -21, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
        }, track)
        chuangjianYuanjiao(knob, 9)
        local state = SUI.text(btn, initial and "On" or "Off", Ziti.Bold, 12,
            initial and Yanse.White or Yanse.GreyMuted, UDim2.new(1, -68, 0.5, 0), UDim2.new(0, 34, 0, 18))
        state.AnchorPoint = Vector2.new(1, 0.5)
        state.TextXAlignment = Enum.TextXAlignment.Right
        SUI.sw[btn] = {track = track, knob = knob, state = state}
        return btn
    end

    function SUI.setSwitch(btn, on, instant)
        local r = SUI.sw[btn]
        if not r then return end
        local guidaoYanse = on and Yanse.BrandRed or SUI.offTrack
        local huakuaiZuobiao = on and UDim2.new(1, -21, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
        r.state.Text = on and "On" or "Off"
        r.state.TextColor3 = on and Yanse.White or Yanse.GreyMuted
        if instant then
            r.track.BackgroundColor3 = guidaoYanse
            r.knob.Position = huakuaiZuobiao
        else
            SUI.tween(r.track, 0.18, {BackgroundColor3 = guidaoYanse})
            SUI.tween(r.knob, 0.18, {Position = huakuaiZuobiao})
        end
    end

    function SUI.syncSwatches()
        local cur = string.lower(DangqianZhutiShiliu or "")
        for _, s in ipairs(SUI.swatches) do
            s.ring.Transparency = (string.lower(s.color:ToHex()) == cur) and 0 or 1
        end
    end

    local biaotou = SUI.make("Frame", {
        Name = "PageHeader", BackgroundTransparency = 1, LayoutOrder = 0, Size = UDim2.new(1, 0, 0, 48)
    }, ShezhiGundong)
    SUI.text(biaotou, "Settings", Ziti.Bold, 22, Yanse.White, UDim2.new(0, 2, 0, 0), UDim2.new(1, -4, 0, 28))
    SUI.text(biaotou, "Preferences, tools and appearance", Ziti.Book, 12, Yanse.GreyMuted, UDim2.new(0, 2, 0, 30), UDim2.new(1, -4, 0, 16))

    local tongyong = SUI.section("General", 10)
    BiaozhiQiehuanBtn = SUI.switchRow(tongyong, "Overhead user tags", "Show AN tags above players' heads", Shezhi.ShowTags)

    local wangluo = SUI.section("Network", 20)

    local _, tpCtl = SUI.row(wangluo, "Teleportation", "Rejoin this server or hop to a new one", {ctrlW = 200, stack = true})
    local ChongjinBtn = SUI.button(tpCtl, "Rejoin", "default", 96)
    ChongjinBtn.LayoutOrder = 1
    ChongjinBtn.MouseButton1Click:Connect(function()
        if ChongjinBtn:GetAttribute("Busy") then return end
        ChongjinBtn:SetAttribute("Busy", true)
        ChongjinBtn.Text = "Rejoining..."
        duilieZidongZhixing()
        ChuansongFuwu:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        task.delay(5, function()
            ChongjinBtn.Text = "Rejoin"
            ChongjinBtn:SetAttribute("Busy", nil)
        end)
    end)

    local FuwuqiTiaohuanBtn = SUI.button(tpCtl, "Serverhop", "default", 96)
    FuwuqiTiaohuanBtn.LayoutOrder = 2
    FuwuqiTiaohuanBtn.MouseButton1Click:Connect(function()
        if FuwuqiTiaohuanBtn:GetAttribute("Busy") then return end
        local req = request or httpQingqiu or (syn and syn.request)
        if not req then
            SUI.flash(FuwuqiTiaohuanBtn, "Unsupported")
            return
        end
        FuwuqiTiaohuanBtn:SetAttribute("Busy", true)
        FuwuqiTiaohuanBtn.Text = "Searching..."
        task.spawn(function()
            local xuanzhong
            local ok, res = pcall(req, {Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"})
            if ok and res and res.StatusCode == 200 then
                local okShuju, data = pcall(function() return HttpFuwu:JSONDecode(res.Body) end)
                if okShuju and data and data.data then
                    local fuwuqi = {}
                    for _, s in ipairs(data.data) do
                        if s.playing < s.maxPlayers and s.id ~= game.JobId then
                            table.insert(fuwuqi, s.id)
                        end
                    end
                    if #fuwuqi > 0 then xuanzhong = fuwuqi[math.random(1, #fuwuqi)] end
                end
            end
            if xuanzhong then
                FuwuqiTiaohuanBtn.Text = "Joining..."
                duilieZidongZhixing()
                ChuansongFuwu:TeleportToPlaceInstance(game.PlaceId, xuanzhong, LocalPlayer)
                task.wait(5)
            else
                FuwuqiTiaohuanBtn.Text = "No servers"
                task.wait(1.6)
            end
            FuwuqiTiaohuanBtn.Text = "Serverhop"
            FuwuqiTiaohuanBtn:SetAttribute("Busy", nil)
        end)
    end)

    local _, idCtl = SUI.row(wangluo, "Server ID", "Copy this ID, or paste one and press Enter to join", {ctrlW = 256, stack = true})
    local fuzhiW = 72
    JiaruIdKuang.Text = ""
    JiaruIdKuang.PlaceholderText = "Paste a Job ID..."
    JiaruIdKuang.TextXAlignment = Enum.TextXAlignment.Left
    JiaruIdKuang.LayoutOrder = 1
    SUI.field(JiaruIdKuang, SUI.narrow and UDim2.new(1, -(fuzhiW + 8), 1, 0) or UDim2.new(0, 176, 1, 0))
    SUI.pad(JiaruIdKuang, 0, 10, 0, 10)
    JiaruIdKuang.Parent = idCtl

    JiaruIdKuang.FocusLost:Connect(function(enter)
        local id = JiaruIdKuang.Text:gsub("%s", "")
        if enter and id ~= "" then
            duilieZidongZhixing()
            ChuansongFuwu:TeleportToPlaceInstance(game.PlaceId, id, LocalPlayer)
        end
    end)

    local FuzhiIdBtn = SUI.button(idCtl, "Copy ID", "default", fuzhiW)
    FuzhiIdBtn.LayoutOrder = 2
    FuzhiIdBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(tostring(game.JobId))
            SUI.flash(FuzhiIdBtn, "Copied")
        else
            SUI.flash(FuzhiIdBtn, "Unsupported")
        end
    end)

    local appearance = SUI.section("Appearance", 30)
    local sekaDaxiao = SUI.narrow and 26 or 28
    local _, themeCtl = SUI.row(appearance, "Theme color", "Pick a preset or type a hex code", {ctrlW = 264, stack = true})
    themeCtl.UIListLayout.Padding = UDim.new(0, SUI.narrow and 6 or 8)

    ShiliuShuru.Text = DangqianZhutiShiliu
    ShiliuShuru.PlaceholderText = "RRGGBB"
    ShiliuShuru.TextXAlignment = Enum.TextXAlignment.Center
    ShiliuShuru.LayoutOrder = 1
    SUI.field(ShiliuShuru, UDim2.new(0, SUI.narrow and 68 or 76, 0, sekaDaxiao + 4))
    ShiliuShuru.Font = Ziti.Bold
    ShiliuShuru.Parent = themeCtl

    SUI.presets = {
        Color3.fromRGB(229, 9, 20),
        Color3.fromRGB(0, 120, 255),
        Color3.fromRGB(0, 255, 127),
        Color3.fromRGB(138, 43, 226),
        Color3.fromRGB(255, 215, 0)
    }
    for i, color in ipairs(SUI.presets) do
        local yanseBtn = SUI.make("TextButton", {
            Text = "", AutoButtonColor = false, BorderSizePixel = 0, LayoutOrder = 1 + i,
            BackgroundColor3 = color, Size = UDim2.new(0, sekaDaxiao, 0, sekaDaxiao)
        }, themeCtl)
        yanseBtn:SetAttribute("ANThemePreset", true)
        chuangjianYuanjiao(yanseBtn, sekaDaxiao / 2)

        local ring = SUI.make("UIStroke", {
            Color = Color3.new(1, 1, 1), Thickness = 2, Transparency = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        }, yanseBtn)
        SUI.swatches[#SUI.swatches + 1] = {color = color, ring = ring}
        BangdingJiaohuShengyin(yanseBtn)
        yanseBtn.MouseButton1Click:Connect(function() yingyongXinZhuti(color) end)
    end
    SUI.syncSwatches()

    local zhichi = SUI.section("Support", 40)
    local fankuiKuangH = 76
    local fankuiDing = 70
    local FankuiPai = SUI.row(zhichi, "Feedback and reports", "Tell us about bugs or ideas. 3 reports, then a 5 minute cooldown.", {
        noControls = true, height = fankuiDing + fankuiKuangH + 10 + SUI.btnH + 14
    })
    FankuiPai.Name = "FeedbackRow"

    FankuiShuru.Text = ""
    FankuiShuru.PlaceholderText = "Describe the bug or idea..."
    FankuiShuru.TextXAlignment = Enum.TextXAlignment.Left
    FankuiShuru.TextYAlignment = Enum.TextYAlignment.Top
    FankuiShuru.TextWrapped = true
    FankuiShuru.MultiLine = true
    FankuiShuru.Font = Ziti.Book
    FankuiShuru.TextSize = 13
    FankuiShuru.Position = UDim2.new(0, 16, 0, fankuiDing)
    SUI.field(FankuiShuru, UDim2.new(1, -32, 0, fankuiKuangH))
    FankuiShuru.Font = Ziti.Book
    FankuiShuru.TextSize = 13
    FankuiShuru.TextColor3 = Color3.fromRGB(225, 225, 225)
    SUI.pad(FankuiShuru, 8, 10, 8, 10)
    FankuiShuru.Parent = FankuiPai

    SUI.button(FankuiPai, "Submit", "primary", 104, FankuiTijiaoBtn)
    FankuiTijiaoBtn.AnchorPoint = Vector2.new(1, 0)
    FankuiTijiaoBtn.Position = UDim2.new(1, -16, 0, fankuiDing + fankuiKuangH + 10)

    local jiekou = SUI.section("Interface", 50)
    local _, uiCtl = SUI.row(jiekou, "Destroy UI", "Closes this window and cleans everything up", {ctrlW = 110, stack = false})
    local HuimieBtn = SUI.button(uiCtl, "Destroy UI", "danger", 104)
    HuimieBtn.MouseButton1Click:Connect(function()

        if HuimieBtn:GetAttribute("Armed") ~= true then
            HuimieBtn:SetAttribute("Armed", true)
            HuimieBtn.Text = "Confirm?"
            task.delay(3, function()
                if HuimieBtn.Parent and HuimieBtn:GetAttribute("Armed") == true then
                    HuimieBtn:SetAttribute("Armed", nil)
                    HuimieBtn.Text = "Destroy UI"
                end
            end)
            return
        end
        pcall(function() qingkongDaobanTupianHuancun() end)
        pcall(function() jianchaChu() end)
        if AN_HUANJING.AN_UNIVERSAL_GUI == PingmuJiemian then AN_HUANJING.AN_UNIVERSAL_GUI = nil end
        if AN_HUANJING.AN_UNIVERSAL_CLEANUP and AN_HUANJING.AN_UNIVERSAL_GUI == nil then AN_HUANJING.AN_UNIVERSAL_CLEANUP = nil end
        PingmuJiemian:Destroy()
    end)

    local footer = SUI.text(ShezhiGundong, "Changes save automatically.", Ziti.Book, 11, Yanse.GreyMuted, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 16))
    footer.LayoutOrder = 200
    footer.TextXAlignment = Enum.TextXAlignment.Center

    SUI.syncs[#SUI.syncs + 1] = function()
        SUI.setSwitch(BiaozhiQiehuanBtn, Shezhi.ShowTags == true, true)
        SUI.syncSwatches()
    end
    ShezhiKuangjia:GetPropertyChangedSignal("Visible"):Connect(function()
        if not ShezhiKuangjia.Visible then return end
        for _, fn in ipairs(SUI.syncs) do pcall(fn) end
    end)
end

local zuidaJubao = 3
local dangqianJubao = 0
local shiJubaoYisuo = false
local lengqueShichang = 300
local shuapingSuodingWenjian = "AN/NFX_SpamLock.txt"

pcall(function()
    if isfile and readfile and isfile(shuapingSuodingWenjian) then
        local yibaocunShijian = tonumber(readfile(shuapingSuodingWenjian))
        if yibaocunShijian and (os.time() - yibaocunShijian) < lengqueShichang then
            shiJubaoYisuo = true
            FankuiShuru.Text = "SEND FEATURE LOCKED DUE TO SPAM. PLEASE WAIT 5 MINS."
            FankuiShuru.TextEditable = false
            FankuiTijiaoBtn.Text = "Locked"
            FankuiTijiaoBtn.BackgroundColor3 = Color3.fromRGB(150, 20, 20)
        end
    end
end)

FankuiTijiaoBtn.MouseButton1Click:Connect(function()
    if shiJubaoYisuo then return end

    local text = FankuiShuru.Text
    if text == "" then return end

    dangqianJubao = dangqianJubao + 1
    local shiShuapingChufa = false

    if dangqianJubao >= zuidaJubao then
        shiJubaoYisuo = true
        shiShuapingChufa = true

        pcall(function()
            if writefile then writefile(shuapingSuodingWenjian, tostring(os.time())) end
        end)

        FankuiShuru.Text = "SEND FEATURE LOCKED DUE TO SPAM. PLEASE WAIT 5 MINS."
        FankuiShuru.TextEditable = false
        FankuiTijiaoBtn.Text = "Locked"
        FankuiTijiaoBtn.BackgroundColor3 = Color3.fromRGB(150, 20, 20)
    end

    task.spawn(function()
        local req = request or httpQingqiu or (syn and syn.request)
        if not req then
            FankuiTijiaoBtn.Text = "Unsupported"
            task.wait(2)
            FankuiTijiaoBtn.Text = shiJubaoYisuo and "Locked" or "Submit"
            return
        end

        local url = "https://discord.com/api/webhooks/1525456253331964004/SY6JCjkvak3s1c1nTn4pDq89VamfjXXcEWqZtHNjSli9ilAJULWQKpGoMJDgJoQN8-Fk"

        local qianruBiaoti = "🚨 New Report Received!"
        local qianruMiaoshu = "**User:** `" .. LocalPlayer.Name .. "`\n**Message:**\n```\n" .. text .. "\n```"
        local qianruYanse = tonumber("0xE50914")

        if shiShuapingChufa then
            qianruBiaoti = "🛑 SPAM PREVENTED"
            qianruMiaoshu = "**User:** `" .. LocalPlayer.Name .. "` hit the rate limit.\nThey are now locked out for 5 minutes across all sessions.\n**Final Message:**\n```\n" .. text .. "\n```"
            qianruYanse = tonumber("0xFF0000")
        end

        local zaihe = {
            content = "<@975571423919759410>",
            embeds = {
                {
                    title = qianruBiaoti,
                    description = qianruMiaoshu,
                    color = qianruYanse,
                    fields = {
                        {
                            name = "📱 Mobile User ID Copy",
                            value = "` " .. tostring(LocalPlayer.UserId) .. " `",
                            inline = true
                        },
                        {
                            name = "💻 PC User ID Copy",
                            value = "```lua\n" .. tostring(LocalPlayer.UserId) .. "\n```",
                            inline = false
                        }
                    },
                    footer = { text = "AN Universal Auto-Report System" }
                }
            }
        }

        local chenggong, res = pcall(function()
            return req({
                Url = url,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpFuwu:JSONEncode(zaihe)
            })
        end)

        if chenggong and not shiShuapingChufa then
            FankuiShuru.Text = ""
            FankuiTijiaoBtn.Text = "Sent!"
            FankuiTijiaoBtn.BackgroundColor3 = Color3.fromRGB(46, 125, 50)
            task.wait(2)
            if not shiJubaoYisuo then
                FankuiTijiaoBtn.Text = "Submit"
                FankuiTijiaoBtn.BackgroundColor3 = Yanse.BrandRed
            end
        elseif not chenggong and not shiShuapingChufa then
            FankuiTijiaoBtn.Text = "Error"
            task.wait(2)
            FankuiTijiaoBtn.Text = "Submit"
        end
    end)
end)

BiaozhiQiehuanBtn.MouseButton1Click:Connect(function()
    Shezhi.ShowTags = not Shezhi.ShowTags
    baocunShezhi()
    AN_HUANJING.AN_SettingsUI.setSwitch(BiaozhiQiehuanBtn, Shezhi.ShowTags)
    gengxinToudingKejian()
end)

gengxinDongtaiZhutiYanse = function(newColor)
    local jiuYanse = Yanse.BrandRed
    Yanse.BrandRed = newColor

    if PingmuJiemian and PingmuJiemian.Parent then
        for _, object in ipairs(PingmuJiemian:GetDescendants()) do
            pcall(function()
                if object:IsA("GuiObject") then
                    local shiZhutiYushe = false
                    pcall(function()
                        shiZhutiYushe = object:GetAttribute("ANThemePreset") == true
                    end)
                    if not shiZhutiYushe then
                        if object.BackgroundColor3 == jiuYanse then object.BackgroundColor3 = newColor end
                        if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
                            if object.TextColor3 == jiuYanse then object.TextColor3 = newColor end
                        end
                        if object:IsA("ImageLabel") or object:IsA("ImageButton") then
                            if object.ImageColor3 == jiuYanse then object.ImageColor3 = newColor end
                        end
                    end
                elseif object:IsA("UIStroke") then
                    if object.Color == jiuYanse then object.Color = newColor end
                elseif object:IsA("ScrollingFrame") then
                    if object.ScrollBarImageColor3 == jiuYanse then object.ScrollBarImageColor3 = newColor end
                end
            end)
        end
    end

    pcall(function() PinpaiLogo.TextColor3 = newColor end)
    pcall(function() DaohangZhishi.BackgroundColor3 = newColor end)
    pcall(function() SuoxiaoMiaobian.Color = newColor end)
    pcall(function() BofangBtn.BackgroundColor3 = newColor end)
    pcall(function() ZhixingDongzuoBtn.BackgroundColor3 = newColor end)
    pcall(function() FankuiTijiaoBtn.BackgroundColor3 = newColor end)
    pcall(function() MingdanDaN.TextColor3 = newColor end)
    pcall(function() ShezhiGundong.ScrollBarImageColor3 = newColor end)
    pcall(function() DaobanSousuoBtn.BackgroundColor3 = newColor end)
    pcall(function() PiratedResults.ScrollBarImageColor3 = newColor end)
    pcall(function() DaobanZhixing.BackgroundColor3 = newColor end)
    pcall(function() PiratedFavoriteBtn.BackgroundColor3 = newColor end)
    for _, dot in ipairs(YuandianRongna:GetChildren()) do
        if dot:IsA("Frame") and dot.Size.X.Offset > 10 then
            dot.BackgroundColor3 = newColor
        end
    end
end

yingyongXinZhuti = function(color)
    if typeof(color) ~= "Color3" then return end
    local hex = color:ToHex()
    ShiliuShuru.Text = hex
    DangqianZhutiShiliu = hex
    DangqianZhutiYanse = color
    gengxinDongtaiZhutiYanse(color)
    pcall(function()
        if writefile then writefile(ZHUTI_WENJIAN, hex) end
    end)
end

ShiliuShuru.FocusLost:Connect(function()
    local raw = ShiliuShuru.Text:gsub("[#%s]", "")
    local ok, newColor = false, nil
    if #raw == 6 or #raw == 3 then ok, newColor = pcall(Color3.fromHex, raw) end
    if ok and typeof(newColor) == "Color3" then
        yingyongXinZhuti(newColor)
    else

        ShiliuShuru.Text = DangqianZhutiShiliu
        local miaobian = ShiliuShuru:FindFirstChildOfClass("UIStroke")
        if miaobian then
            miaobian.Color = Color3.fromRGB(198, 40, 40)
            DonghuaFuwu:Create(miaobian, TweenInfo.new(0.6), {Color = Yanse.Border}):Play()
        end
    end
end)

do

    local jichuYingyong = yingyongXinZhuti
    yingyongXinZhuti = function(color)
        jichuYingyong(color)
        pcall(function() AN_HUANJING.AN_SettingsUI.syncSwatches() end)
    end
end

local dangqianSuoyin = 1
local kejianDianying = {}

local jichuKapianKuandu, baseCardHeight = 135, 202
local lunboJianju = 24

if shiShouji2() then
    local shikouKuandu = Xiangji.ViewportSize.X
    local shoujiSuofang = math.clamp(shikouKuandu / 900, 0.68, 0.78)
    jichuKapianKuandu = math.floor(jichuKapianKuandu * shoujiSuofang)
    baseCardHeight = math.floor(baseCardHeight * shoujiSuofang)
    lunboJianju = 12
end

local function bujuKapian(instant)
    local rongqiW = LunboRongqi.AbsoluteSize.X
    local zhongxinX = rongqiW / 2
    for i, card in ipairs(DianyingLunbo:GetChildren()) do
        if card:IsA("Frame") then
            local pianyiCongDangqian = i - dangqianSuoyin
            local mubiaoX = zhongxinX + pianyiCongDangqian * (jichuKapianKuandu + lunboJianju) - jichuKapianKuandu / 2
            local shiZhongxin = (i == dangqianSuoyin)
            local dist = math.abs(pianyiCongDangqian)
            local mubiaoSuofang = shiZhongxin and 1.05 or 0.82
            local mubiaoToumingdu = shiZhongxin and 0 or math.clamp(0.4 + dist * 0.18, 0.4, 0.85)
            local mubiaoZ = shiZhongxin and 10 or (10 - dist)

            card.ZIndex = math.max(mubiaoZ, 1)

            local zhongdianZuobiao = UDim2.new(0, mubiaoX, 0.45, 0)
            local zhongdianDaxiao = UDim2.new(0, jichuKapianKuandu * mubiaoSuofang, 0, baseCardHeight * mubiaoSuofang)

            if instant then
                card.Position = zhongdianZuobiao
                card.Size = zhongdianDaxiao
            else
                DonghuaFuwu:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Position = zhongdianZuobiao,
                    Size = zhongdianDaxiao
                }):Play()
            end

            local img = card:FindFirstChild("PosterImg")
            local haibaoGuangyun = card:FindFirstChild("PosterGlow")
            if img then
                DonghuaFuwu:Create(img, TweenInfo.new(0.35), {ImageTransparency = mubiaoToumingdu}):Play()
            end
            if haibaoGuangyun then
                DonghuaFuwu:Create(haibaoGuangyun, TweenInfo.new(0.35), {ImageTransparency = mubiaoToumingdu == 0 and 0.4 or 1}):Play()
            end
        end
    end
end

local function gengxinYuandian()
    YuandianRongna:ClearAllChildren()
    local buju = Instance.new("UIListLayout")
    buju.FillDirection = Enum.FillDirection.Horizontal
    buju.HorizontalAlignment = Enum.HorizontalAlignment.Center
    buju.VerticalAlignment = Enum.VerticalAlignment.Center
    buju.Padding = UDim.new(0, 6)
    buju.Parent = YuandianRongna
    for i = 1, #kejianDianying do
        local dot = Instance.new("Frame")
        dot.BorderSizePixel = 0
        dot.LayoutOrder = i
        dot.Parent = YuandianRongna
        chuangjianYuanjiao(dot, 3)

        if i == dangqianSuoyin then
            dot.Size = UDim2.new(0, 14, 0, 4)
            dot.BackgroundColor3 = Yanse.BrandRed
        else
            dot.Size = UDim2.new(0, 4, 0, 4)
            dot.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end
    end
end

local shituXiangqingPingmu
local shituDaobanShoucangXiangqing

local function chuangjianDianyingKapian(dianying, suoyin)
    local card = Instance.new("Frame")
    card.Name = "Card_" .. suoyin
    card.AnchorPoint = Vector2.new(0, 0.5)
    card.Size = UDim2.new(0, jichuKapianKuandu, 0, baseCardHeight)
    card.BackgroundTransparency = 1
    card.ZIndex = 2
    card.Parent = DianyingLunbo

    local haibaoTupian = Instance.new("ImageLabel")
    haibaoTupian.Name = "PosterImg"
    haibaoTupian.Size = UDim2.new(1, 0, 1, 0)
    haibaoTupian.BackgroundColor3 = Yanse.DarkCard
    haibaoTupian.ScaleType = Enum.ScaleType.Crop
    haibaoTupian.ZIndex = 3
    haibaoTupian.Parent = card

    local haibaoGuangyun = Instance.new("ImageLabel")
    haibaoGuangyun.Name = "PosterGlow"
    haibaoGuangyun.Size = UDim2.new(1, 16, 1, 16)
    haibaoGuangyun.Position = UDim2.new(0, -8, 0, -8)
    haibaoGuangyun.BackgroundTransparency = 1
    haibaoGuangyun.Image = "rbxassetid://6014261993"
    haibaoGuangyun.ImageColor3 = Color3.new(0, 0, 0)
    haibaoGuangyun.ImageTransparency = 1
    haibaoGuangyun.ScaleType = Enum.ScaleType.Slice
    haibaoGuangyun.SliceCenter = Rect.new(49, 49, 450, 450)
    haibaoGuangyun.ZIndex = 2
    haibaoGuangyun.Parent = card

    JiazaiTupianYibu(haibaoTupian, dianying.Img or (dianying.SavedPirated and dianying.SavedPirated.Image))

    local dianjiGanying = Instance.new("TextButton")
    dianjiGanying.Size = UDim2.new(1, 0, 1, 0)
    dianjiGanying.BackgroundTransparency = 1
    dianjiGanying.Text = ""
    dianjiGanying.ZIndex = 4
    dianjiGanying.Parent = card
    BangdingJiaohuShengyin(dianjiGanying)

    dianjiGanying.MouseButton1Click:Connect(function()
        if suoyin == dangqianSuoyin then
            if dianying.Kind == "pirated" and shituDaobanShoucangXiangqing then
                shituDaobanShoucangXiangqing(dianying)
            else
                shituXiangqingPingmu(dianying)
            end
        else
            dangqianSuoyin = suoyin
            bujuKapian(false)
            gengxinYuandian()
        end
    end)

    dianjiGanying.MouseEnter:Connect(function()
        if suoyin == dangqianSuoyin then
            DonghuaFuwu:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, jichuKapianKuandu * 1.08, 0, baseCardHeight * 1.08)
            }):Play()
        end
    end)

    dianjiGanying.MouseLeave:Connect(function()
        if suoyin == dangqianSuoyin then
            DonghuaFuwu:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, jichuKapianKuandu * 1.05, 0, baseCardHeight * 1.05)
            }):Play()
        end
    end)

    return card
end

gengxinLunbo = function()
    DianyingLunbo:ClearAllChildren()
    local chaxun = SousuoKuang.Text:lower()
    kejianDianying = {}
    for _, dianying in ipairs(Dianying) do
        local biaotiWenben = tostring(dianying.Title or "")
        local pipeiSousuo = chaxun == "" or biaotiWenben:lower():find(chaxun, 1, true)
        local pipeiFenlei = (DangqianFenlei == "All") or (DangqianFenlei == "My List" and shiShoucang(biaotiWenben)) or (dianying.Genre == DangqianFenlei)

        local pipeiBiaozhi = true
        for activeTag, _ in pairs(HuoyueBiaozhiShaixuan) do
            local youBiaozhi = false
            if dianying.ParsedTags then
                for _, t in ipairs(dianying.ParsedTags) do
                    if t == activeTag then youBiaozhi = true break end
                end
            end
            if not youBiaozhi then pipeiBiaozhi = false break end
        end

        if pipeiSousuo and pipeiFenlei and pipeiBiaozhi then
            table.insert(kejianDianying, dianying)
        end
    end

    if DangqianFenlei == "My List" then
        for _, saved in ipairs(huodeYibaocunDaobanTiaomu()) do
            local biaotiWenben = tostring(saved.Title or "Untitled Script")
            if chaxun == "" or biaotiWenben:lower():find(chaxun, 1, true) then
                table.insert(kejianDianying, {
                    Kind = "pirated",
                    Title = biaotiWenben,
                    Img = saved.Image,
                    Creator = saved.Owner or "ScriptBlox",
                    Genre = "Pirated",
                    Date = tostring(saved.UpdatedAt or saved.CreatedAt or ""),
                    Description = saved.Description or "",
                    Tags = saved.Tags or {},
                    Script = saved.Script,
                    SavedPirated = saved
                })
            end
        end
    end

    KongZhuangtai.Visible = (#kejianDianying == 0)
    dangqianSuoyin = math.clamp(dangqianSuoyin, 1, math.max(#kejianDianying, 1))

    for i, dianying in ipairs(kejianDianying) do
        chuangjianDianyingKapian(dianying, i)
    end

    task.defer(function()
        bujuKapian(true)
        gengxinYuandian()
    end)
end

local function pingyiLunbo(step)
    if #kejianDianying == 0 then return end
    dangqianSuoyin = dangqianSuoyin + step
    if dangqianSuoyin < 1 then dangqianSuoyin = #kejianDianying end
    if dangqianSuoyin > #kejianDianying then dangqianSuoyin = 1 end
    bujuKapian(false)
    gengxinYuandian()
end

local DaobanKuangjia
;(function()
DaobanKuangjia = Instance.new("Frame")
DaobanKuangjia.Name = "PiratedFrame"
DaobanKuangjia.Size = UDim2.new(1, 0, 1, -52)
DaobanKuangjia.Position = UDim2.new(0, 0, 0, 52)
DaobanKuangjia.BackgroundTransparency = 1
DaobanKuangjia.Visible = false
DaobanKuangjia.Parent = ZhuKuangjia

local DaobanSousuo = Instance.new("TextBox")
DaobanSousuo.Name = "PiratedSearch"
DaobanSousuo.Size = UDim2.new(1, -36, 0, 38)
DaobanSousuo.Position = UDim2.new(0, 18, 0, 12)
DaobanSousuo.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
DaobanSousuo.BorderSizePixel = 0
DaobanSousuo.Text = ""
DaobanSousuo.PlaceholderText = "Search ScriptBlox scripts..."
DaobanSousuo.PlaceholderColor3 = Color3.fromRGB(105, 105, 105)
DaobanSousuo.TextColor3 = Yanse.White
DaobanSousuo.Font = Ziti.Book
DaobanSousuo.TextSize = 13
DaobanSousuo.ClearTextOnFocus = false
DaobanSousuo.TextXAlignment = Enum.TextXAlignment.Left
DaobanSousuo.ZIndex = 5
DaobanSousuo.Parent = DaobanKuangjia
chuangjianYuanjiao(DaobanSousuo, 5)
chuangjianMiaobian(DaobanSousuo, Yanse.Border, 1, 0.4)

local DaobanSousuoBtn = Instance.new("TextButton")
DaobanSousuoBtn.Name = "PiratedSearchBtn"
DaobanSousuoBtn.Size = UDim2.new(0, 78, 0, 30)
DaobanSousuoBtn.Position = UDim2.new(1, -94, 0, 16)
DaobanSousuoBtn.BackgroundColor3 = Yanse.BrandRed
DaobanSousuoBtn.Text = "Search"
DaobanSousuoBtn.TextColor3 = Yanse.White
DaobanSousuoBtn.Font = Ziti.Bold
DaobanSousuoBtn.TextSize = 12
DaobanSousuoBtn.AutoButtonColor = false
DaobanSousuoBtn.ZIndex = 6
DaobanSousuoBtn.Parent = DaobanKuangjia
chuangjianYuanjiao(DaobanSousuoBtn, 4)
BangdingJiaohuShengyin(DaobanSousuoBtn)

local DaobanZtBiaoqian = Instance.new("TextLabel")
DaobanZtBiaoqian.Size = UDim2.new(1, -36, 0, 22)
DaobanZtBiaoqian.Position = UDim2.new(0, 18, 0, 54)
DaobanZtBiaoqian.BackgroundTransparency = 1
DaobanZtBiaoqian.Text = "ScriptBlox  •  Verified / Key / Universal / Patched status shown on every result"
DaobanZtBiaoqian.TextColor3 = Yanse.GreyMuted
DaobanZtBiaoqian.Font = Ziti.Book
DaobanZtBiaoqian.TextSize = 10
DaobanZtBiaoqian.TextXAlignment = Enum.TextXAlignment.Left
DaobanZtBiaoqian.ZIndex = 4
DaobanZtBiaoqian.Parent = DaobanKuangjia

PiratedResults = Instance.new("ScrollingFrame")
PiratedResults.Name = "PiratedResults"
PiratedResults.Size = UDim2.new(1, -36, 1, -112)
PiratedResults.Position = UDim2.new(0, 18, 0, 82)
PiratedResults.BackgroundTransparency = 1
PiratedResults.BorderSizePixel = 0
PiratedResults.ScrollBarThickness = 5
PiratedResults.ScrollBarImageColor3 = Yanse.BrandRed
PiratedResults.CanvasSize = UDim2.new(0, 0, 0, 0)
PiratedResults.AutomaticCanvasSize = Enum.AutomaticSize.Y
PiratedResults.ScrollingDirection = Enum.ScrollingDirection.Y
PiratedResults.ZIndex = 3
PiratedResults.Parent = DaobanKuangjia

PiratedGrid = Instance.new("UIGridLayout")
PiratedGrid.CellPadding = UDim2.new(0, 10, 0, 10)
PiratedGrid.CellSize = UDim2.new(0, 205, 0, 184)
PiratedGrid.SortOrder = Enum.SortOrder.LayoutOrder
PiratedGrid.Parent = PiratedResults

local DaobanKong = Instance.new("TextLabel")
DaobanKong.Name = "PiratedEmpty"
DaobanKong.Size = UDim2.new(1, 0, 0, 60)
DaobanKong.BackgroundTransparency = 1
DaobanKong.Text = "Search ScriptBlox to find scripts."
DaobanKong.TextColor3 = Yanse.GreyMuted
DaobanKong.Font = Ziti.Book
DaobanKong.TextSize = 13
DaobanKong.Visible = true
DaobanKong.ZIndex = 4
DaobanKong.Parent = PiratedResults

local DaobanXiangqing = Instance.new("ScrollingFrame")
DaobanXiangqing.Name = "PiratedDetail"

DaobanXiangqing.Size = UDim2.new(1, -36, 1, -28)
DaobanXiangqing.Position = UDim2.new(0, 18, 0, 12)
DaobanXiangqing.BackgroundColor3 = Yanse.DarkCard
DaobanXiangqing.BorderSizePixel = 0
DaobanXiangqing.Visible = false
DaobanXiangqing.ZIndex = 10
DaobanXiangqing.ScrollBarThickness = 5
DaobanXiangqing.ScrollBarImageColor3 = Yanse.BrandRed
DaobanXiangqing.CanvasSize = UDim2.new(0, 0, 0, 0)
DaobanXiangqing.AutomaticCanvasSize = Enum.AutomaticSize.Y
DaobanXiangqing.ScrollingDirection = Enum.ScrollingDirection.Y
DaobanXiangqing.Parent = DaobanKuangjia
chuangjianYuanjiao(DaobanXiangqing, 7)
chuangjianMiaobian(DaobanXiangqing, Yanse.Border, 1, 0.35)

local DaobanXiangqingBianju = Instance.new("UIPadding")
DaobanXiangqingBianju.PaddingTop = UDim.new(0, 12)
DaobanXiangqingBianju.PaddingBottom = UDim.new(0, 20)
DaobanXiangqingBianju.PaddingLeft = UDim.new(0, 12)
DaobanXiangqingBianju.PaddingRight = UDim.new(0, 12)
DaobanXiangqingBianju.Parent = DaobanXiangqing

local DaobanXiangqingBuju = Instance.new("UIListLayout")
DaobanXiangqingBuju.FillDirection = Enum.FillDirection.Vertical
DaobanXiangqingBuju.HorizontalAlignment = Enum.HorizontalAlignment.Left
DaobanXiangqingBuju.SortOrder = Enum.SortOrder.LayoutOrder
DaobanXiangqingBuju.Padding = UDim.new(0, 10)
DaobanXiangqingBuju.Parent = DaobanXiangqing

local DaobanFanhui = Instance.new("TextButton")
DaobanFanhui.Name = "PiratedBack"
DaobanFanhui.Size = UDim2.new(0, 70, 0, 30)
DaobanFanhui.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
DaobanFanhui.Text = "Back"
DaobanFanhui.TextColor3 = Yanse.White
DaobanFanhui.Font = Ziti.Bold
DaobanFanhui.TextSize = 12
DaobanFanhui.AutoButtonColor = false
DaobanFanhui.LayoutOrder = 1
DaobanFanhui.ZIndex = 12
DaobanFanhui.Parent = DaobanXiangqing
chuangjianYuanjiao(DaobanFanhui, 4)
BangdingJiaohuShengyin(DaobanFanhui)

local DaobanZhutu = Instance.new("Frame")
DaobanZhutu.Name = "PiratedHero"
DaobanZhutu.Size = UDim2.new(1, -24, 0, 252)
DaobanZhutu.BackgroundTransparency = 1
DaobanZhutu.LayoutOrder = 2
DaobanZhutu.ZIndex = 11
DaobanZhutu.Parent = DaobanXiangqing

local DaobanXiangqingTupian = Instance.new("ImageLabel")
DaobanXiangqingTupian.Name = "PiratedDetailImage"
DaobanXiangqingTupian.Size = UDim2.new(0, 150, 0, 112)
DaobanXiangqingTupian.Position = UDim2.new(0, 0, 0, 10)
DaobanXiangqingTupian.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
DaobanXiangqingTupian.BorderSizePixel = 0
DaobanXiangqingTupian.ScaleType = Enum.ScaleType.Crop
DaobanXiangqingTupian.ZIndex = 11
DaobanXiangqingTupian.Parent = DaobanZhutu
chuangjianYuanjiao(DaobanXiangqingTupian, 6)

local DaobanWuTupian = Instance.new("TextLabel")
DaobanWuTupian.Size = UDim2.new(1, 0, 1, 0)
DaobanWuTupian.BackgroundTransparency = 1
DaobanWuTupian.Text = "NO IMAGE"
DaobanWuTupian.TextColor3 = Yanse.GreyMuted
DaobanWuTupian.Font = Ziti.Bold
DaobanWuTupian.TextSize = 10
DaobanWuTupian.ZIndex = 10
DaobanWuTupian.Parent = DaobanZhutu

local DaobanZhutuXinxi = Instance.new("Frame")
DaobanZhutuXinxi.Size = UDim2.new(1, -162, 1, 0)
DaobanZhutuXinxi.Position = UDim2.new(0, 162, 0, 0)
DaobanZhutuXinxi.BackgroundTransparency = 1
DaobanZhutuXinxi.ZIndex = 11
DaobanZhutuXinxi.Parent = DaobanZhutu

local DaobanXiangqingBiaoti = Instance.new("TextLabel")
DaobanXiangqingBiaoti.Name = "PiratedDetailTitle"
DaobanXiangqingBiaoti.Size = UDim2.new(1, 0, 0, 44)
DaobanXiangqingBiaoti.BackgroundTransparency = 1
DaobanXiangqingBiaoti.TextColor3 = Yanse.White
DaobanXiangqingBiaoti.Font = Ziti.Heavy
DaobanXiangqingBiaoti.TextSize = 21
DaobanXiangqingBiaoti.TextXAlignment = Enum.TextXAlignment.Left
DaobanXiangqingBiaoti.TextYAlignment = Enum.TextYAlignment.Top
DaobanXiangqingBiaoti.TextWrapped = true
DaobanXiangqingBiaoti.TextTruncate = Enum.TextTruncate.AtEnd
DaobanXiangqingBiaoti.ZIndex = 11
DaobanXiangqingBiaoti.Parent = DaobanZhutuXinxi

local DaobanYuanxinxi = Instance.new("TextLabel")
DaobanYuanxinxi.Name = "PiratedMeta"
DaobanYuanxinxi.Size = UDim2.new(1, 0, 0, 68)
DaobanYuanxinxi.Position = UDim2.new(0, 0, 0, 48)
DaobanYuanxinxi.BackgroundTransparency = 1
DaobanYuanxinxi.TextColor3 = Yanse.GreyMuted
DaobanYuanxinxi.Font = Ziti.Medium
DaobanYuanxinxi.TextSize = 11
DaobanYuanxinxi.TextWrapped = true
DaobanYuanxinxi.TextXAlignment = Enum.TextXAlignment.Left
DaobanYuanxinxi.TextYAlignment = Enum.TextYAlignment.Top
DaobanYuanxinxi.ZIndex = 11
DaobanYuanxinxi.Parent = DaobanZhutuXinxi

local DaobanBiaozhiKuangjia = Instance.new("Frame")
DaobanBiaozhiKuangjia.Name = "PiratedTagsFrame"
DaobanBiaozhiKuangjia.Size = UDim2.new(1, -24, 0, 58)
DaobanBiaozhiKuangjia.LayoutOrder = 3
DaobanBiaozhiKuangjia.BackgroundTransparency = 1
DaobanBiaozhiKuangjia.ZIndex = 11
DaobanBiaozhiKuangjia.Parent = DaobanXiangqing

local DaobanZhuBiaozhiBiaoqian = Instance.new("TextLabel")
DaobanZhuBiaozhiBiaoqian.Size = UDim2.new(1, 0, 0, 18)
DaobanZhuBiaozhiBiaoqian.BackgroundTransparency = 1
DaobanZhuBiaozhiBiaoqian.Text = "STATUS"
DaobanZhuBiaozhiBiaoqian.TextColor3 = Yanse.GreyMuted
DaobanZhuBiaozhiBiaoqian.Font = Ziti.Bold
DaobanZhuBiaozhiBiaoqian.TextSize = 9
DaobanZhuBiaozhiBiaoqian.TextXAlignment = Enum.TextXAlignment.Left
DaobanZhuBiaozhiBiaoqian.Parent = DaobanBiaozhiKuangjia

local DaobanBiaozhiGundong = Instance.new("ScrollingFrame")
DaobanBiaozhiGundong.Size = UDim2.new(1, 0, 0, 34)
DaobanBiaozhiGundong.Position = UDim2.new(0, 0, 0, 18)
DaobanBiaozhiGundong.BackgroundTransparency = 1
DaobanBiaozhiGundong.BorderSizePixel = 0
DaobanBiaozhiGundong.ScrollBarThickness = 0
DaobanBiaozhiGundong.ScrollingDirection = Enum.ScrollingDirection.X
DaobanBiaozhiGundong.CanvasSize = UDim2.new(0, 0, 0, 0)
DaobanBiaozhiGundong.ZIndex = 12
DaobanBiaozhiGundong.Parent = DaobanBiaozhiKuangjia

local DaobanBiaozhiBuju = Instance.new("UIListLayout")
DaobanBiaozhiBuju.FillDirection = Enum.FillDirection.Horizontal
DaobanBiaozhiBuju.VerticalAlignment = Enum.VerticalAlignment.Center
DaobanBiaozhiBuju.Padding = UDim.new(0, 7)
DaobanBiaozhiBuju.Parent = DaobanBiaozhiGundong

local DaobanChuangzuozheBiaozhiBiaoqian = Instance.new("TextLabel")
DaobanChuangzuozheBiaozhiBiaoqian.Size = UDim2.new(1, 0, 0, 18)
DaobanChuangzuozheBiaozhiBiaoqian.BackgroundTransparency = 1
DaobanChuangzuozheBiaozhiBiaoqian.Text = "CREATOR TAGS"
DaobanChuangzuozheBiaozhiBiaoqian.TextColor3 = Yanse.GreyMuted
DaobanChuangzuozheBiaozhiBiaoqian.Font = Ziti.Bold
DaobanChuangzuozheBiaozhiBiaoqian.TextSize = 9
DaobanChuangzuozheBiaozhiBiaoqian.TextXAlignment = Enum.TextXAlignment.Left
DaobanChuangzuozheBiaozhiBiaoqian.Parent = DaobanXiangqing

local DaobanChuangzuozheBiaozhiGundong = Instance.new("ScrollingFrame")
DaobanChuangzuozheBiaozhiGundong.Name = "PiratedCreatorTagsScroll"
DaobanChuangzuozheBiaozhiGundong.Size = UDim2.new(1, -24, 0, 54)
DaobanChuangzuozheBiaozhiGundong.LayoutOrder = 4
DaobanChuangzuozheBiaozhiGundong.BackgroundTransparency = 1
DaobanChuangzuozheBiaozhiGundong.BorderSizePixel = 0
DaobanChuangzuozheBiaozhiGundong.ScrollBarThickness = 0
DaobanChuangzuozheBiaozhiGundong.ScrollingDirection = Enum.ScrollingDirection.X
DaobanChuangzuozheBiaozhiGundong.CanvasSize = UDim2.new(0, 0, 0, 0)
DaobanChuangzuozheBiaozhiGundong.ZIndex = 12
DaobanChuangzuozheBiaozhiGundong.Parent = DaobanXiangqing

local DaobanChuangzuozheBiaozhiBuju = Instance.new("UIListLayout")
DaobanChuangzuozheBiaozhiBuju.FillDirection = Enum.FillDirection.Horizontal
DaobanChuangzuozheBiaozhiBuju.VerticalAlignment = Enum.VerticalAlignment.Center
DaobanChuangzuozheBiaozhiBuju.Padding = UDim.new(0, 7)
DaobanChuangzuozheBiaozhiBuju.Parent = DaobanChuangzuozheBiaozhiGundong

local function tianjiaDaobanBiaozhi(text, kind, parent)
    parent = parent or DaobanBiaozhiGundong
    local tag = Instance.new("TextLabel")
    tag.AutomaticSize = Enum.AutomaticSize.X
    tag.Size = UDim2.new(0, 0, 0, 27)

    tag.BackgroundColor3 = kind == "good" and Yanse.BrandRed or Color3.fromRGB(45, 45, 45)
    tag.TextColor3 = Yanse.White
    tag.Font = Ziti.Bold
    tag.TextSize = 10
    tag.Text = "  " .. tostring(text) .. "  "
    tag.ZIndex = 12
    tag.Parent = parent
    chuangjianYuanjiao(tag, 13)
    return tag
end

local DaobanMiaoshuBiaotou = Instance.new("TextLabel")
DaobanMiaoshuBiaotou.Size = UDim2.new(1, -24, 0, 24)
DaobanMiaoshuBiaotou.LayoutOrder = 5
DaobanMiaoshuBiaotou.BackgroundTransparency = 1
DaobanMiaoshuBiaotou.Text = "DESCRIPTION / FEATURES"
DaobanMiaoshuBiaotou.TextColor3 = Yanse.White
DaobanMiaoshuBiaotou.Font = Ziti.Bold
DaobanMiaoshuBiaotou.TextSize = 12
DaobanMiaoshuBiaotou.TextXAlignment = Enum.TextXAlignment.Left
DaobanMiaoshuBiaotou.ZIndex = 11
DaobanMiaoshuBiaotou.Parent = DaobanXiangqing

local DaobanMiaoshu = Instance.new("TextLabel")
DaobanMiaoshu.Name = "PiratedDescription"
DaobanMiaoshu.Size = UDim2.new(1, -24, 0, 120)
DaobanMiaoshu.AutomaticSize = Enum.AutomaticSize.Y
DaobanMiaoshu.LayoutOrder = 6
DaobanMiaoshu.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
DaobanMiaoshu.TextColor3 = Yanse.GreyLight
DaobanMiaoshu.Font = Ziti.Book
DaobanMiaoshu.TextSize = 12
DaobanMiaoshu.TextWrapped = true
DaobanMiaoshu.TextXAlignment = Enum.TextXAlignment.Left
DaobanMiaoshu.TextYAlignment = Enum.TextYAlignment.Top
DaobanMiaoshu.ZIndex = 11
DaobanMiaoshu.Parent = DaobanXiangqing
chuangjianYuanjiao(DaobanMiaoshu, 5)
local miaoshuBianju = Instance.new("UIPadding")
miaoshuBianju.PaddingTop = UDim.new(0, 10)
miaoshuBianju.PaddingBottom = UDim.new(0, 10)
miaoshuBianju.PaddingLeft = UDim.new(0, 10)
miaoshuBianju.PaddingRight = UDim.new(0, 10)
miaoshuBianju.Parent = DaobanMiaoshu

local DaobanPinglunBiaotou = Instance.new("TextLabel")
DaobanPinglunBiaotou.Size = UDim2.new(1, -24, 0, 28)
DaobanPinglunBiaotou.LayoutOrder = 7
DaobanPinglunBiaotou.BackgroundTransparency = 1
DaobanPinglunBiaotou.Text = "COMMUNITY COMMENTS"
DaobanPinglunBiaotou.TextColor3 = Yanse.White
DaobanPinglunBiaotou.Font = Ziti.Bold
DaobanPinglunBiaotou.TextSize = 12
DaobanPinglunBiaotou.TextXAlignment = Enum.TextXAlignment.Left
DaobanPinglunBiaotou.ZIndex = 11
DaobanPinglunBiaotou.Parent = DaobanXiangqing

local DaobanPinglun = Instance.new("Frame")
DaobanPinglun.Name = "PiratedComments"
DaobanPinglun.Size = UDim2.new(1, -24, 0, 10)
DaobanPinglun.AutomaticSize = Enum.AutomaticSize.Y
DaobanPinglun.LayoutOrder = 8
DaobanPinglun.BackgroundTransparency = 1
DaobanPinglun.ZIndex = 11
DaobanPinglun.Parent = DaobanXiangqing

local DaobanPinglunBuju = Instance.new("UIListLayout")
DaobanPinglunBuju.Padding = UDim.new(0, 7)
DaobanPinglunBuju.SortOrder = Enum.SortOrder.LayoutOrder
DaobanPinglunBuju.Parent = DaobanPinglun

local DaobanZhixingPai = Instance.new("Frame")
DaobanZhixingPai.Name = "PiratedExecuteRow"
DaobanZhixingPai.Size = UDim2.new(1, 0, 0, 116)
DaobanZhixingPai.Position = UDim2.new(0, 0, 0, 120)
DaobanZhixingPai.BackgroundTransparency = 1
DaobanZhixingPai.ZIndex = 12
DaobanZhixingPai.Parent = DaobanZhutuXinxi

local DaobanZhixingBuju = Instance.new("UIListLayout")
DaobanZhixingBuju.FillDirection = Enum.FillDirection.Vertical
DaobanZhixingBuju.HorizontalAlignment = Enum.HorizontalAlignment.Left
DaobanZhixingBuju.VerticalAlignment = Enum.VerticalAlignment.Top
DaobanZhixingBuju.Padding = UDim.new(0, 6)
DaobanZhixingBuju.Parent = DaobanZhixingPai

local DaobanZhixing = Instance.new("TextButton")
DaobanZhixing.Name = "PiratedExecute"
DaobanZhixing.Size = UDim2.new(1, 0, 0, 34)
DaobanZhixing.BackgroundColor3 = Yanse.BrandRed
DaobanZhixing.Text = "Execute"
DaobanZhixing.TextColor3 = Yanse.White
DaobanZhixing.Font = Ziti.Bold
DaobanZhixing.TextSize = 12
DaobanZhixing.AutoButtonColor = false
DaobanZhixing.ZIndex = 12
DaobanZhixing.Parent = DaobanZhixingPai
chuangjianYuanjiao(DaobanZhixing, 4)
BangdingJiaohuShengyin(DaobanZhixing)

PiratedOpenTab = Instance.new("TextButton")
PiratedOpenTab.Name = "PiratedOpenTab"
PiratedOpenTab.Size = UDim2.new(1, 0, 0, 34)
PiratedOpenTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PiratedOpenTab.Text = "Open Tab"
PiratedOpenTab.TextColor3 = Yanse.White
PiratedOpenTab.Font = Ziti.Bold
PiratedOpenTab.TextSize = 12
PiratedOpenTab.AutoButtonColor = false
PiratedOpenTab.ZIndex = 12
PiratedOpenTab.Parent = DaobanZhixingPai
chuangjianYuanjiao(PiratedOpenTab, 4)
chuangjianMiaobian(PiratedOpenTab, Yanse.Border, 1)
BangdingJiaohuShengyin(PiratedOpenTab)

PiratedFavoriteBtn = Instance.new("TextButton")
PiratedFavoriteBtn.Name = "PiratedFavoriteBtn"
PiratedFavoriteBtn.Size = UDim2.new(1, 0, 0, 34)
PiratedFavoriteBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PiratedFavoriteBtn.Text = "+ My List"
PiratedFavoriteBtn.TextColor3 = Yanse.White
PiratedFavoriteBtn.Font = Ziti.Bold
PiratedFavoriteBtn.TextSize = 11
PiratedFavoriteBtn.AutoButtonColor = false
PiratedFavoriteBtn.ZIndex = 12
PiratedFavoriteBtn.Parent = DaobanZhixingPai
chuangjianYuanjiao(PiratedFavoriteBtn, 4)
chuangjianMiaobian(PiratedFavoriteBtn, Yanse.Border, 1)
BangdingJiaohuShengyin(PiratedFavoriteBtn)

do
piratedScripts = {}
selectedPirated = nil
selectedPiratedComments = {}
piratedSearchBusy = false
piratedPage = 1
piratedTotalPages = 1
piratedLoadingMore = false

local function daobanHttpHuode(url)
    local chenggong, body = pcall(function()
        return game:HttpGet(url)
    end)
    if not chenggong or not body then return nil end
    local ok, decoded = pcall(function()
        return HttpFuwu:JSONDecode(body)
    end)
    if not ok then return nil end
    return decoded
end

local function qingkongDaobanJieguo()
    for _, child in ipairs(PiratedResults:GetChildren()) do
        if child:IsA("GuiObject") and child ~= DaobanKong then
            child:Destroy()
        end
    end
end

local function qingkongDaobanPinglun()
    for _, child in ipairs(DaobanPinglun:GetChildren()) do
        if child:IsA("GuiObject") then child:Destroy() end
    end
end

local function qingkongDaobanBiaozhi()
    for _, child in ipairs(DaobanBiaozhiGundong:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
end

local function daobanYouxiMingzi(scriptData)
    return (scriptData.game and scriptData.game.name) or "Unknown Game"
end

local function geshiDaobanDate(value)
    if type(value) ~= "string" or value == "" then return "Unknown date" end
    local y, m, d = value:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)")
    if y then return y .. "-" .. m .. "-" .. d end
    return value
end

function chuangjianDaobanJieguo(scriptData, suoyin)
    local card = Instance.new("TextButton")
    card.Name = "PiratedCard_" .. suoyin
    card.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    card.BorderSizePixel = 0
    card.Text = ""
    card.AutoButtonColor = false
    card.LayoutOrder = suoyin
    card.ZIndex = 5
    card.Parent = PiratedResults
    chuangjianYuanjiao(card, 7)
    chuangjianMiaobian(card, Yanse.Border, 1, 0.5)
    BangdingJiaohuShengyin(card)

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0, 78, 1, -12)
    img.Position = UDim2.new(0, 6, 0, 6)
    img.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    img.BorderSizePixel = 0
    img.ScaleType = Enum.ScaleType.Crop
    img.ZIndex = 6
    img.Parent = card
    chuangjianYuanjiao(img, 5)
    JiazaiTupianYibu(img, scriptData.image or (scriptData.game and scriptData.game.imageUrl), true, true)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -94, 0, 32)
    title.Position = UDim2.new(0, 90, 0, 9)
    title.BackgroundTransparency = 1
    title.Text = tostring(scriptData.title or "Untitled Script")
    title.TextColor3 = Yanse.White
    title.Font = Ziti.Bold
    title.TextSize = 12
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextYAlignment = Enum.TextYAlignment.Top
    title.TextWrapped = true
    title.ZIndex = 6
    title.Parent = card

    local meta = Instance.new("TextLabel")
    meta.Size = UDim2.new(1, -94, 0, 38)
    meta.Position = UDim2.new(0, 90, 0, 44)
    meta.BackgroundTransparency = 1
    meta.Text = daobanYouxiMingzi(scriptData) .. "\n" ..
        tostring(scriptData.views or 0) .. " views • " .. tostring(scriptData.likeCount or 0) .. " likes"
    meta.TextColor3 = Yanse.GreyMuted
    meta.Font = Ziti.Book
    meta.TextSize = 10
    meta.TextWrapped = true
    meta.TextXAlignment = Enum.TextXAlignment.Left
    meta.TextYAlignment = Enum.TextYAlignment.Top
    meta.ZIndex = 6
    meta.Parent = card

    local tags = Instance.new("Frame")
    tags.Size = UDim2.new(1, -94, 0, 48)
    tags.Position = UDim2.new(0, 90, 1, -54)
    tags.BackgroundTransparency = 1
    tags.ZIndex = 7
    tags.Parent = card

    local biaozhiWangge = Instance.new("UIGridLayout")
    biaozhiWangge.CellSize = UDim2.new(0.5, -3, 0, 20)
    biaozhiWangge.CellPadding = UDim2.new(0, 6, 0, 4)
    biaozhiWangge.FillDirection = Enum.FillDirection.Horizontal
    biaozhiWangge.FillDirectionMaxCells = 2
    biaozhiWangge.SortOrder = Enum.SortOrder.LayoutOrder
    biaozhiWangge.Parent = tags

    local function kapianBiaozhi(text, kind, order)
        local tag = Instance.new("TextLabel")
        tag.Size = UDim2.new(0, 0, 0, 20)
        tag.BackgroundColor3 = kind == "good" and Yanse.BrandRed or Color3.fromRGB(48, 48, 48)
        tag.TextColor3 = Yanse.White
        tag.Font = Ziti.Bold
        tag.TextSize = 8
        tag.Text = tostring(text)
        tag.TextXAlignment = Enum.TextXAlignment.Center
        tag.TextTruncate = Enum.TextTruncate.AtEnd
        tag.LayoutOrder = order
        tag.ZIndex = 8
        tag.Parent = tags
        chuangjianYuanjiao(tag, 10)
    end

    kapianBiaozhi(scriptData.verified and "VERIFIED" or "UNVERIFIED", scriptData.verified and "good" or "neutral", 1)
    kapianBiaozhi(scriptData.key and "KEY SYSTEM" or "KEYLESS", "neutral", 2)
    kapianBiaozhi(scriptData.isUniversal and "UNIVERSAL" or "GAME", scriptData.isUniversal and "good" or "neutral", 3)
    kapianBiaozhi(scriptData.isPatched and "PATCHED" or "WORKING", scriptData.isPatched and "neutral" or "good", 4)

    card.MouseEnter:Connect(function()
        DonghuaFuwu:Create(card, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)
    card.MouseLeave:Connect(function()
        DonghuaFuwu:Create(card, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
    end)

    card.MouseButton1Click:Connect(function()
        local slug = scriptData.slug or scriptData._id
        local detail = slug and daobanHttpHuode("https://scriptblox.com/api/script/" .. tostring(slug))
        local full = detail and detail.script or scriptData
        if not full then return end
        xuanranDaobanXiangqing(full)
    end)
end

function xuanranDaobanXiangqing(full, preloadedComments)
    if not full then return end
    selectedPirated = full
    selectedPiratedComments = type(preloadedComments) == "table" and preloadedComments or {}

    DaobanSousuo.Visible = false
    DaobanSousuoBtn.Visible = false
    DaobanZtBiaoqian.Visible = false
    PiratedResults.Visible = false
    DaobanXiangqing.Visible = true
    DaobanXiangqing.CanvasPosition = Vector2.new(0, 0)

    DaobanXiangqingBiaoti.Text = tostring(full.title or "Untitled Script")
    local xiangqingTupianUrl = full.image or (full.game and full.game.imageUrl)
    DaobanXiangqingTupian.Image = ""
    DaobanWuTupian.Visible = not (xiangqingTupianUrl and xiangqingTupianUrl ~= "")
    JiazaiTupianYibu(DaobanXiangqingTupian, xiangqingTupianUrl, true, true)

    local dianzan = tonumber(full.likeCount or full.Likes) or 0
    local cai = tonumber(full.dislikeCount or full.Dislikes) or 0
    local zongToupiao = dianzan + cai
    local pingfen = zongToupiao > 0 and math.floor((dianzan / zongToupiao) * 100 + 0.5) or 0
    local owner = (full.owner and full.owner.username) or full.Owner or "Unknown"
    DaobanYuanxinxi.Text = daobanYouxiMingzi(full) .. "\n" ..
        "★ " .. tostring(pingfen) .. "% positive • " .. tostring(dianzan) .. " likes • " .. tostring(cai) .. " dislikes\n" ..
        tostring(full.views or full.Views or 0) .. " views • by " .. owner .. "\nUpdated: " .. geshiDaobanDate(full.updatedAt or full.UpdatedAt or full.createdAt or full.CreatedAt)

    qingkongDaobanBiaozhi()
    for _, child in ipairs(DaobanChuangzuozheBiaozhiGundong:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    local shiYirenzheng = full.verified == true or full.Verified == true
    local shiJianhao = full.key == true or full.Key == true
    local isUniversal = full.isUniversal == true or full.Universal == true
    local isPatched = full.isPatched == true or full.Patched == true
    tianjiaDaobanBiaozhi(shiYirenzheng and "VERIFIED" or "UNVERIFIED", shiYirenzheng and "good" or "neutral")
    tianjiaDaobanBiaozhi(shiJianhao and "KEY SYSTEM" or "KEYLESS", "neutral")
    tianjiaDaobanBiaozhi(isUniversal and "UNIVERSAL" or "GAME SPECIFIC", isUniversal and "good" or "neutral")
    tianjiaDaobanBiaozhi(isPatched and "PATCHED" or "WORKING", "neutral")
    tianjiaDaobanBiaozhi(tostring(full.scriptType or full.ScriptType or "FREE"):upper(), "neutral")
    if full.visibility or full.Visibility then tianjiaDaobanBiaozhi(tostring(full.visibility or full.Visibility):upper(), "neutral") end

    local tags = full.tags or full.Tags
    if type(tags) == "table" then
        for _, tagName in ipairs(tags) do
            local text = tostring(tagName)
            if text ~= "" then tianjiaDaobanBiaozhi(text, "neutral", DaobanChuangzuozheBiaozhiGundong) end
        end
    end
    task.defer(function()
        DaobanBiaozhiGundong.CanvasSize = UDim2.new(0, DaobanBiaozhiBuju.AbsoluteContentSize.X + 8, 0, 0)
        DaobanChuangzuozheBiaozhiGundong.CanvasSize = UDim2.new(0, DaobanChuangzuozheBiaozhiBuju.AbsoluteContentSize.X + 8, 0, 0)
    end)

    DaobanMiaoshu.Text = tostring(full.features or full.description or full.Description or "No description provided.")

    qingkongDaobanPinglun()
    local comments = selectedPiratedComments
    if #comments == 0 and full._id then
        local pinglunXiangying = daobanHttpHuode("https://scriptblox.com/api/comment/" .. tostring(full._id) .. "?page=1&max=50")
        comments = pinglunXiangying and pinglunXiangying.result and pinglunXiangying.result.comments or {}
        selectedPiratedComments = type(comments) == "table" and comments or {}
    end

    if type(comments) ~= "table" or #comments == 0 then
        local none = Instance.new("TextLabel")
        none.Size = UDim2.new(1, 0, 0, 34)
        none.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
        none.Text = "No comments available."
        none.TextColor3 = Yanse.GreyMuted
        none.Font = Ziti.Book
        none.TextSize = 11
        none.TextXAlignment = Enum.TextXAlignment.Left
        none.ZIndex = 11
        none.Parent = DaobanPinglun
        chuangjianYuanjiao(none, 5)
    else
        for i, comment in ipairs(comments) do
            local box = Instance.new("Frame")
            box.Size = UDim2.new(1, 0, 0, 78)
            box.BackgroundColor3 = Color3.fromRGB(30, 31, 34)
            box.BorderSizePixel = 0
            box.LayoutOrder = i
            box.ZIndex = 11
            box.Parent = DaobanPinglun
            chuangjianYuanjiao(box, 6)

            local qiangdiao = Instance.new("Frame")
            qiangdiao.Size = UDim2.new(0, 3, 1, 0)
            qiangdiao.BackgroundColor3 = Yanse.BrandRed
            qiangdiao.BorderSizePixel = 0
            qiangdiao.ZIndex = 12
            qiangdiao.Parent = box
            chuangjianYuanjiao(qiangdiao, 2)

            local touxiang = Instance.new("ImageLabel")
            touxiang.Size = UDim2.new(0, 28, 0, 28)
            touxiang.Position = UDim2.new(0, 10, 0, 9)
            touxiang.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
            touxiang.BorderSizePixel = 0
            touxiang.ScaleType = Enum.ScaleType.Crop
            touxiang.ZIndex = 12
            touxiang.Parent = box
            chuangjianYuanjiao(touxiang, 14)
            if comment.commentBy and comment.commentBy.profilePicture then
                JiazaiTupianYibu(touxiang, comment.commentBy.profilePicture, true, true)
            end

            local username = tostring((comment.commentBy and comment.commentBy.username) or comment.Username or "Unknown")
            local user = Instance.new("TextLabel")
            user.Size = UDim2.new(1, -54, 0, 19)
            user.Position = UDim2.new(0, 47, 0, 7)
            user.BackgroundTransparency = 1
            user.Text = "@" .. username .. ((comment.commentBy and comment.commentBy.verified) and "  ✓" or "")
            user.TextColor3 = Yanse.White
            user.Font = Ziti.Bold
            user.TextSize = 10
            user.TextXAlignment = Enum.TextXAlignment.Left
            user.ZIndex = 12
            user.Parent = box

            local shijianchuo = Instance.new("TextLabel")
            shijianchuo.Size = UDim2.new(1, -54, 0, 16)
            shijianchuo.Position = UDim2.new(0, 47, 0, 26)
            shijianchuo.BackgroundTransparency = 1
            shijianchuo.Text = geshiDaobanDate(comment.createdAt or comment.updatedAt or comment.CreatedAt or comment.UpdatedAt)
            shijianchuo.TextColor3 = Color3.fromRGB(148, 150, 156)
            shijianchuo.Font = Ziti.Book
            shijianchuo.TextSize = 9
            shijianchuo.TextXAlignment = Enum.TextXAlignment.Left
            shijianchuo.ZIndex = 12
            shijianchuo.Parent = box

            local body = Instance.new("TextLabel")
            body.Size = UDim2.new(1, -20, 0, 28)
            body.Position = UDim2.new(0, 10, 0, 45)
            body.BackgroundTransparency = 1
            body.Text = tostring(comment.text or comment.Text or "")
            body.TextColor3 = Yanse.GreyLight
            body.Font = Ziti.Book
            body.TextSize = 10
            body.TextWrapped = true
            body.TextXAlignment = Enum.TextXAlignment.Left
            body.TextYAlignment = Enum.TextYAlignment.Top
            body.ZIndex = 12
            body.Parent = box
        end
    end

    PiratedFavoriteBtn.Text = wodeLiebiaoBiaoqian(shiDaobanShoucang(tostring(full.title or "Untitled Script")))
end

shituDaobanShoucangXiangqing = function(saved)
    local full = {
        title = saved.Title,
        script = saved.Script,
        image = saved.Image,
        game = saved.Game,
        features = saved.Description,
        likeCount = saved.Likes,
        dislikeCount = saved.Dislikes,
        views = saved.Views,
        owner = {username = saved.Owner or "Unknown"},
        updatedAt = saved.UpdatedAt,
        createdAt = saved.CreatedAt,
        tags = saved.Tags,
        verified = saved.Verified,
        key = saved.Key,
        isUniversal = saved.Universal,
        isPatched = saved.Patched,
        scriptType = saved.ScriptType,
        visibility = saved.Visibility,
        _id = saved.Id,
        slug = saved.Slug
    }
    xuanranDaobanXiangqing(full, saved.Comments or {})
    luyouDaoShitu("pirated")
    gengxinXiangkaHang(DaobanXiangka)
end

function sousuoDaoban(chaxun)
    chaxun = tostring(chaxun or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if chaxun == "" or piratedSearchBusy then return end
    piratedSearchBusy = true
    DaobanSousuoBtn.Text = "Searching..."
    qingkongDaobanTupianHuancun()
    qingkongDaobanJieguo()
    DaobanKong.Visible = true
    DaobanKong.Text = "Searching ScriptBlox..."

    task.spawn(function()
        local encoded = HttpFuwu:UrlEncode(chaxun)
        local url = "https://scriptblox.com/api/script/search?q=" .. encoded .. "&page=1&max=20&sortBy=views&order=desc"
        local response = daobanHttpHuode(url)
        piratedScripts = response and response.result and response.result.scripts or {}
        piratedPage = 1
        piratedTotalPages = tonumber(response and response.result and response.result.totalPages) or 1
        piratedLoadingMore = false
        qingkongDaobanJieguo()
        if #piratedScripts == 0 then
            DaobanKong.Visible = true
            DaobanKong.Text = "No ScriptBlox results found."
        else
            DaobanKong.Visible = false
            for i, scriptData in ipairs(piratedScripts) do
                chuangjianDaobanJieguo(scriptData, i)
            end
        end
        DaobanSousuoBtn.Text = "Search"
        piratedSearchBusy = false
    end)
end

DaobanSousuoBtn.MouseButton1Click:Connect(function()
    sousuoDaoban(DaobanSousuo.Text)
end)

DaobanSousuo.FocusLost:Connect(function(enterPressed)
    if enterPressed then sousuoDaoban(DaobanSousuo.Text) end
end)

DaobanFanhui.MouseButton1Click:Connect(function()
    selectedPirated = nil
    qingkongDaobanTupianHuancun()
    DaobanXiangqing.Visible = false
    DaobanSousuo.Visible = true
    DaobanSousuoBtn.Visible = true
    DaobanZtBiaoqian.Visible = true
    PiratedResults.Visible = true
end)

DaobanZhixing.MouseButton1Click:Connect(function()
    if not selectedPirated then return end
    local laiyuan = selectedPirated.script
    if type(laiyuan) ~= "string" or laiyuan == "" then
        DaobanZhixing.Text = "No Source"
        task.delay(1.5, function()
            if DaobanZhixing then DaobanZhixing.Text = "Execute" end
        end)
        return
    end
    task.spawn(function()
        local ok = pcall(function()
            local fn = loadstring(laiyuan)
            if fn then fn() end
        end)
        DaobanZhixing.Text = ok and "Executed" or "Failed"
        task.wait(1.2)
        if DaobanZhixing then DaobanZhixing.Text = "Execute" end
    end)

    if shiDaobanShoucang(tostring(selectedPirated.title or "Untitled Script")) then
        local idx = chazhaoShoucangSuoyin(tostring(selectedPirated.title or "Untitled Script"), "pirated")
        if idx and Shoucang[idx] then
            Shoucang[idx].Script = laiyuan
            Shoucang[idx].Description = selectedPirated.features or selectedPirated.description or Shoucang[idx].Description
            Shoucang[idx].Comments = selectedPiratedComments or Shoucang[idx].Comments
            baocunShoucang()
        end
    end
end)

PiratedOpenTab.MouseButton1Click:Connect(function()
    if not selectedPirated then return end
    local laiyuan = selectedPirated.script
    if type(laiyuan) ~= "string" or laiyuan == "" then
        PiratedOpenTab.Text = "No Source"
        task.delay(1.5, function() if PiratedOpenTab then PiratedOpenTab.Text = "Open Tab" end end)
        return
    end
    dakaiJiaobenZaiDaoyanXiangka(selectedPirated.title or "ScriptBlox Script", laiyuan)
end)

PiratedFavoriteBtn.MouseButton1Click:Connect(function()
    if not selectedPirated then return end
    qiehuanDaobanShoucang(selectedPirated, selectedPiratedComments)
    PiratedFavoriteBtn.Text = wodeLiebiaoBiaoqian(shiDaobanShoucang(tostring(selectedPirated.title or "Untitled Script")))
    if DangqianFenlei == "My List" then gengxinLunbo() end
end)

PiratedGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PiratedResults.CanvasSize = UDim2.new(0, 0, 0, PiratedGrid.AbsoluteContentSize.Y + 18)
end)

PiratedResults.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseWheel then
        local maxY = math.max(PiratedResults.AbsoluteCanvasSize.Y - PiratedResults.AbsoluteSize.Y, 0)
        if PiratedResults.CanvasPosition.Y >= maxY - 120 and not piratedLoadingMore and piratedPage < piratedTotalPages and not piratedSearchBusy then
            piratedLoadingMore = true
            local xiayiYe = piratedPage + 1
            task.spawn(function()
                local encoded = HttpFuwu:UrlEncode(DaobanSousuo.Text)
                local response = daobanHttpHuode("https://scriptblox.com/api/script/search?q=" .. encoded .. "&page=" .. tostring(xiayiYe) .. "&max=20&sortBy=views&order=desc")
                local more = response and response.result and response.result.scripts or {}
                if #more > 0 then
                    piratedPage = xiayiYe
                    piratedTotalPages = tonumber(response.result.totalPages) or piratedTotalPages
                    local kaishiSuoyin = #piratedScripts + 1
                    for i, scriptData in ipairs(more) do
                        table.insert(piratedScripts, scriptData)
                        chuangjianDaobanJieguo(scriptData, kaishiSuoyin + i - 1)
                    end
                end
                piratedLoadingMore = false
            end)
        end
    end
end)

DaobanBiaozhiBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    DaobanBiaozhiGundong.CanvasSize = UDim2.new(0, DaobanBiaozhiBuju.AbsoluteContentSize.X + 8, 0, 0)
end)

DaobanPinglunBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    DaobanPinglun.Size = UDim2.new(1, -24, 0, DaobanPinglunBuju.AbsoluteContentSize.Y)
end)

DaobanXiangqingBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    DaobanXiangqing.CanvasSize = UDim2.new(0, 0, 0, DaobanXiangqingBuju.AbsoluteContentSize.Y + 32)
end)

task.defer(function()
    if shiShouji2() then
        PiratedGrid.CellSize = UDim2.new(1, -6, 0, 168)
        PiratedGrid.CellPadding = UDim2.new(0, 6, 0, 8)
        DaobanXiangqingTupian.Size = UDim2.new(0, 112, 0, 96)
        DaobanZhutu.Size = UDim2.new(1, -24, 0, 270)
        DaobanZhutuXinxi.Position = UDim2.new(0, 122, 0, 0)
        DaobanZhutuXinxi.Size = UDim2.new(1, -122, 1, 0)
        DaobanXiangqingBiaoti.TextSize = 17
        DaobanYuanxinxi.TextSize = 9
        DaobanZhixingPai.Position = UDim2.new(0, 0, 0, 120)
        DaobanZhixingPai.Size = UDim2.new(1, 0, 0, 116)
    end
end)

end
end)()

local huoyueShitu = nil
local views = {
    menu = CaidanKuangjia,
    detail = XiangqingKuangjia,
    executor = ZhixingqiKuangjia,
    pirated = DaobanKuangjia,
    credits = MingdanKuangjia,
    settings = ShezhiKuangjia
}
if GuanliKuangjia then views.admin = GuanliKuangjia end

local shituYuandian = {}
for name, kuangjia in pairs(views) do shituYuandian[name] = kuangjia.Position end

luyouDaoShitu = function(viewName)
    if viewName == huoyueShitu then return end
    local chuqu = views[huoyueShitu]
    local laixiang = views[viewName]
    if chuqu and chuqu.Visible then
        local chuMubiao = shituYuandian[huoyueShitu] + UDim2.new(0, 0, 0, 12)
        DonghuaFuwu:Create(chuqu, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = chuMubiao
        }):Play()
    end

    task.delay(0.15, function()
        for name, kuangjia in pairs(views) do
            kuangjia.Visible = (name == viewName)
            if name ~= viewName then kuangjia.Position = shituYuandian[name] end
        end

        if laixiang then
            laixiang.Position = shituYuandian[viewName] + UDim2.new(0, 0, 0, 12)
            DonghuaFuwu:Create(laixiang, TweenInfo.new(0.24, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Position = shituYuandian[viewName]
            }):Play()
        end
    end)

    huoyueShitu = viewName
end

local dangqianBofangLianjie = nil
local dangqianShoucangLianjie = nil
local DangqianXiangqingDianying = nil
local DangqianXiangqingXuanxiang = {HideEffects = false, MuteMusic = false}

local function zhichiMaoziFudongXuanxiang(dianying, optionName)
    if not dianying or dianying.Genre ~= "Hat reanim" then return false end
    local xuanxiang = dianying.Options or dianying.HatReanimOptions or dianying.ReanimOptions
    if type(xuanxiang) == "table" and xuanxiang[optionName] == true then
        return true
    end

    return dianying["Supports" .. optionName] == true
end

local function gengxinFudongXuanxiangAnniu(button, label, enabled)
    button.Text = label .. ": " .. (enabled and "ON" or "OFF")
    button.BackgroundColor3 = enabled and Yanse.BrandRed or Color3.fromRGB(35, 35, 35)
end

local function tihuanBuerShezhi(jiaobenLaiyuan, settingName, enabled)
    local guize = "(" .. settingName .. "%s*=%s*)[%a]+"
    local yixiufuLaiyuan, count = jiaobenLaiyuan:gsub(guize, function(qianzhui)
        return qianzhui .. (enabled and "true" or "false")
    end, 1)
    return yixiufuLaiyuan, count > 0
end

local function zhixingDianyingDaiXuanxiang(dianying)
    local jiaobenLaiyuan = tostring(dianying.Loadstring or "")
    if jiaobenLaiyuan == "" then error("This movie has no loadstring source.") end

    local zhichiYincangTexiao = zhichiMaoziFudongXuanxiang(dianying, "HideEffects")
    local zhichiJingyinYinyue = zhichiMaoziFudongXuanxiang(dianying, "MuteMusic")
    if zhichiYincangTexiao or zhichiJingyinYinyue then
        local youYixiufuShezhi = false

        if zhichiYincangTexiao then
            local yixiufu, found = tihuanBuerShezhi(jiaobenLaiyuan, "HideEffects", DangqianXiangqingXuanxiang.HideEffects == true)
            jiaobenLaiyuan = yixiufu
            youYixiufuShezhi = youYixiufuShezhi or found
        end
        if zhichiJingyinYinyue then
            local yixiufu, found = tihuanBuerShezhi(jiaobenLaiyuan, "MuteMusic", DangqianXiangqingXuanxiang.MuteMusic == true)
            jiaobenLaiyuan = yixiufu
            youYixiufuShezhi = youYixiufuShezhi or found
        end

        if not youYixiufuShezhi then
            local yuanchengUrl = jiaobenLaiyuan:match('game:HttpGet%(%s*"(https?://[^"]+)"%s*%)')
                or jiaobenLaiyuan:match("game:HttpGet%(%s*'(https?://[^']+)'%s*%)")
            if yuanchengUrl then
                local huoquOk, remoteSource = pcall(function() return game:HttpGet(yuanchengUrl) end)
                if huoquOk and type(remoteSource) == "string" then
                    local yixiufuAny = false
                    if zhichiYincangTexiao then
                        local yixiufu, found = tihuanBuerShezhi(remoteSource, "HideEffects", DangqianXiangqingXuanxiang.HideEffects == true)
                        remoteSource = yixiufu
                        yixiufuAny = yixiufuAny or found
                    end
                    if zhichiJingyinYinyue then
                        local yixiufu, found = tihuanBuerShezhi(remoteSource, "MuteMusic", DangqianXiangqingXuanxiang.MuteMusic == true)
                        remoteSource = yixiufu
                        yixiufuAny = yixiufuAny or found
                    end
                    if yixiufuAny then jiaobenLaiyuan = remoteSource end
                end
            end
        end

        if type(AN_HUANJING.trulysettings) ~= "table" then AN_HUANJING.trulysettings = {} end
        if type(AN_HUANJING.trulysettings.patchma) ~= "table" then AN_HUANJING.trulysettings.patchma = {} end
        if type(AN_HUANJING.trulysettings.script) ~= "table" then AN_HUANJING.trulysettings.script = {} end
        if zhichiYincangTexiao then
            AN_HUANJING.trulysettings.script.HideEffects = DangqianXiangqingXuanxiang.HideEffects == true
        end
        if zhichiJingyinYinyue then
            AN_HUANJING.trulysettings.script.MuteMusic = DangqianXiangqingXuanxiang.MuteMusic == true
        end
    end

    local bianyi, compileError = loadstring(jiaobenLaiyuan)
    if not bianyi then error(compileError or "Could not compile movie script.") end
    return bianyi()
end

shituXiangqingPingmu = function(dianying)
    DangqianXiangqingDianying = dianying
    DangqianXiangqingXuanxiang = {HideEffects = false, MuteMusic = false}

    local zhichiYincangTexiao = zhichiMaoziFudongXuanxiang(dianying, "HideEffects")
    local zhichiJingyinYinyue = zhichiMaoziFudongXuanxiang(dianying, "MuteMusic")
    local xuanxiangShuliang = (zhichiYincangTexiao and 1 or 0) + (zhichiJingyinYinyue and 1 or 0)
    FudongXuanxiangPai.Visible = xuanxiangShuliang > 0
    YincangTexiaoXuanxiangBtn.Visible = zhichiYincangTexiao
    JingyinYinyueXuanxiangBtn.Visible = zhichiJingyinYinyue
    if xuanxiangShuliang == 1 then
        if zhichiYincangTexiao then YincangTexiaoXuanxiangBtn.Size = UDim2.new(1, 0, 1, 0) end
        if zhichiJingyinYinyue then JingyinYinyueXuanxiangBtn.Size = UDim2.new(1, 0, 1, 0) end
    else
        YincangTexiaoXuanxiangBtn.Size = UDim2.new(0.5, -4, 1, 0)
        JingyinYinyueXuanxiangBtn.Size = UDim2.new(0.5, -4, 1, 0)
    end
    gengxinFudongXuanxiangAnniu(YincangTexiaoXuanxiangBtn, "Hide Effects", false)
    gengxinFudongXuanxiangAnniu(JingyinYinyueXuanxiangBtn, "Mute Music", false)
    XiangqingMiaoshu.Size = UDim2.new(1, 0, 1, xuanxiangShuliang > 0 and -210 or -170)

    XiangqingTupian.Image = ""
    JiazaiTupianYibu(XiangqingTupian, dianying.Img)
    XiangqingBiaoti.Text = dianying.Title
    YuanxinxiPai.Text = dianying.Creator .. " • " .. (dianying.Genre or "Uncategorized") .. " • " .. (dianying.Date or "")
    XiangqingMiaoshu.Text = dianying.Description
    for _, c in ipairs(BiaozhiXiangqingGundong:GetChildren()) do
        if c:IsA("TextLabel") then c:Destroy() end
    end

    if dianying.ParsedTags then
        for _, tagName in ipairs(dianying.ParsedTags) do
            local tLbl = Instance.new("TextLabel")
            tLbl.Text = tagName
            tLbl.Font = Ziti.Bold
            tLbl.TextSize = 11
            tLbl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            tLbl.TextColor3 = Yanse.White
            local size = WenbenFuwu:GetTextSize(tagName, 11, Ziti.Bold, Vector2.new(999, 20))
            tLbl.Size = UDim2.new(0, size.X + 16, 1, 0)
            chuangjianYuanjiao(tLbl, 13)
            tLbl.Parent = BiaozhiXiangqingGundong
        end
    end

    BiaozhiXiangqingGundong.CanvasSize = UDim2.new(0, XiangqingBiaozhiBuju.AbsoluteContentSize.X + 10, 0, 0)

    if dangqianBofangLianjie then dangqianBofangLianjie:Disconnect() end
    if dangqianShoucangLianjie then dangqianShoucangLianjie:Disconnect() end

    dangqianBofangLianjie = BofangBtn.MouseButton1Click:Connect(function()
        task.spawn(function()
            local ok, err = pcall(function()
                zhixingDianyingDaiXuanxiang(dianying)
            end)
            if not ok then
                warn("[ANHUB] Movie execution failed: " .. tostring(err))
            end
        end)
        if dianying.Genre == "Insta Move" then shezhiSuoxiao(true) end
    end)

    ShoucangBtn.Text = wodeLiebiaoBiaoqian(shiShoucang(dianying.Title))
    dangqianShoucangLianjie = ShoucangBtn.MouseButton1Click:Connect(function()
        qiehuanShoucang(dianying.Title)
        ShoucangBtn.Text = wodeLiebiaoBiaoqian(shiShoucang(dianying.Title))
        if DangqianFenlei == "My List" then gengxinLunbo() end
    end)

    luyouDaoShitu("detail")
end

XiangqingBiaozhiBuju:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    BiaozhiXiangqingGundong.CanvasSize = UDim2.new(0, XiangqingBiaozhiBuju.AbsoluteContentSize.X + 10, 0, 0)
end)

YincangTexiaoXuanxiangBtn.MouseButton1Click:Connect(function()
    if not DangqianXiangqingDianying or not zhichiMaoziFudongXuanxiang(DangqianXiangqingDianying, "HideEffects") then return end
    DangqianXiangqingXuanxiang.HideEffects = not DangqianXiangqingXuanxiang.HideEffects
    gengxinFudongXuanxiangAnniu(YincangTexiaoXuanxiangBtn, "Hide Effects", DangqianXiangqingXuanxiang.HideEffects)
end)

JingyinYinyueXuanxiangBtn.MouseButton1Click:Connect(function()
    if not DangqianXiangqingDianying or not zhichiMaoziFudongXuanxiang(DangqianXiangqingDianying, "MuteMusic") then return end
    DangqianXiangqingXuanxiang.MuteMusic = not DangqianXiangqingXuanxiang.MuteMusic
    gengxinFudongXuanxiangAnniu(JingyinYinyueXuanxiangBtn, "Mute Music", DangqianXiangqingXuanxiang.MuteMusic)
end)

ZuoJiantou.MouseButton1Click:Connect(function() pingyiLunbo(-1) end)
YouJiantou.MouseButton1Click:Connect(function() pingyiLunbo(1) end)
FanhuiBtn.MouseButton1Click:Connect(function() qingkongDaobanTupianHuancun(); luyouDaoShitu("menu"); gengxinXiangkaHang(DianyingXiangka) end)
DianyingXiangka.MouseButton1Click:Connect(function() gengxinXiangkaHang(DianyingXiangka); qingkongDaobanTupianHuancun(); luyouDaoShitu("menu") end)
ZhixingqiXiangka.MouseButton1Click:Connect(function() gengxinXiangkaHang(ZhixingqiXiangka); qingkongDaobanTupianHuancun(); luyouDaoShitu("executor") end)
DaobanXiangka.MouseButton1Click:Connect(function() gengxinXiangkaHang(DaobanXiangka); luyouDaoShitu("pirated") end)
ShezhiXiangka.MouseButton1Click:Connect(function() gengxinXiangkaHang(ShezhiXiangka); qingkongDaobanTupianHuancun(); luyouDaoShitu("settings") end)
MingdanXiangka.MouseButton1Click:Connect(function() gengxinXiangkaHang(MingdanXiangka); qingkongDaobanTupianHuancun(); luyouDaoShitu("credits") end)
if GuanliXiangka then
    GuanliXiangka.MouseButton1Click:Connect(function() gengxinXiangkaHang(GuanliXiangka); qingkongDaobanTupianHuancun(); luyouDaoShitu("admin") end)
end

SousuoKuang:GetPropertyChangedSignal("Text"):Connect(function()
    dangqianSuoyin = 1
    gengxinLunbo()
end)

LunboRongqi:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() bujuKapian(true) end)
SuoxiaoBtn.MouseButton1Click:Connect(function() shezhiSuoxiao(true) end)

YonghuShuruFuwu.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightControl then
            shezhiSuoxiao(not shiSuoxiao)
        end
    end
end)

local chumoKaishiWeizhi = nil
SuoxiaoJiaonang.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        chumoKaishiWeizhi = input.Position
    end
end)

SuoxiaoJiaonang.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if chumoKaishiWeizhi then
            local tuodongChazhi = (input.Position - chumoKaishiWeizhi).Magnitude
            if tuodongChazhi < 10 then shezhiSuoxiao(false) end
            chumoKaishiWeizhi = nil
        end
    end
end)

Xiangji:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local mubiaoDaxiao = huodeMubiaoDaxiao()
    if PiratedGrid then
        local kuandu = PiratedResults.AbsoluteSize.X
        PiratedGrid.CellSize = shiShouji2() and UDim2.new(1, -6, 0, 168) or UDim2.new(0, 205, 0, 184)
        PiratedGrid.CellPadding = shiShouji2() and UDim2.new(0, 6, 0, 8) or UDim2.new(0, 10, 0, 10)
    end
    local shikou = Xiangji.ViewportSize
    ZhuKuangjia.Size = UDim2.new(
        0, math.min(mubiaoDaxiao.X.Offset, shikou.X - 24),
        0, math.min(mubiaoDaxiao.Y.Offset, shikou.Y - 24)
    )
end)

local HuoyueBiaozhi = {}
local FirebaseHuoyueYonghu = {}

local function qingliBiaozhi(player)
    if HuoyueBiaozhi[player] then
        pcall(function() HuoyueBiaozhi[player].Gui:Destroy() end)
        HuoyueBiaozhi[player] = nil
    end
end

-- 头顶标签
local function yingyongToudingBiaozhi(player)
    qingliBiaozhi(player)
    if not Shezhi.ShowTags then return end
    if player == LocalPlayer and not ShiGuanli(player.UserId) then return end
    local juese = player.Character
    local head = juese and juese:WaitForChild("Head", 5)
    if not head then return end

    local bill = Instance.new("BillboardGui")
    bill.Name = "AN_UserTag"
    bill.AlwaysOnTop = true
    bill.Size = UDim2.new(4.5, 0, 1.2, 0)
    bill.StudsOffset = Vector3.new(0, 2.5, 0)
    bill.Adornee = head
    bill.Parent = head

    local kuangjia = Instance.new("Frame")
    kuangjia.Size = UDim2.new(1, 0, 1, 0)
    kuangjia.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    kuangjia.BackgroundTransparency = 0.25
    kuangjia.Parent = bill
    chuangjianYuanjiao(kuangjia, 6)

    local biaozhiMiaobian = chuangjianMiaobian(kuangjia, Yanse.Border, 1.5)

    local wenbenBiaoqian = Instance.new("TextLabel")
    wenbenBiaoqian.Size = UDim2.new(1, 0, 1, 0)
    wenbenBiaoqian.BackgroundTransparency = 1
    wenbenBiaoqian.Font = Ziti.Bold
    wenbenBiaoqian.TextScaled = true

    local wenbenYueshu = Instance.new("UITextSizeConstraint")
    wenbenYueshu.MaxTextSize = 14
    wenbenYueshu.MinTextSize = 6
    wenbenYueshu.Parent = wenbenBiaoqian
    wenbenBiaoqian.Parent = kuangjia

    local role = "AN_Users"
    local rank = HuodeYonghuDengji(player.UserId)
    if rank == 4 then
        role = "AN_Founder"
    elseif rank == 3 then
        role = "AN_Co-founder"
        local jianbian = Instance.new("UIGradient")
        jianbian.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 40, 40)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 215, 0))
        })
        jianbian.Rotation = 45
        jianbian.Parent = wenbenBiaoqian
        HuoyueBiaozhi[player] = { Gui = bill, TextLabel = wenbenBiaoqian, Stroke = biaozhiMiaobian, UserId = player.UserId, Gradient = jianbian, Rank = rank }
    elseif rank == 2 then
        role = "AN_Admin"
        HuoyueBiaozhi[player] = { Gui = bill, TextLabel = wenbenBiaoqian, Stroke = biaozhiMiaobian, UserId = player.UserId, Rank = rank }
    else
        role = "AN_Users"
        HuoyueBiaozhi[player] = { Gui = bill, TextLabel = wenbenBiaoqian, Stroke = biaozhiMiaobian, UserId = player.UserId, Rank = rank }
    end

    wenbenBiaoqian.Text = role

    if not HuoyueBiaozhi[player] then
        HuoyueBiaozhi[player] = { Gui = bill, TextLabel = wenbenBiaoqian, Stroke = biaozhiMiaobian, UserId = player.UserId, Rank = rank }
    end
end

task.spawn(function()
    while task.wait(5) do
        if httpQingqiu then
            local response = httpQingqiu({
                Url = JICHU_URL .. "active_users/" .. JobId .. ".json",
                Method = "GET"
            })

            if response and response.StatusCode == 200 and response.Body ~= "null" then
                local huoyueYonghu = HttpFuwu:JSONDecode(response.Body)
                local yonghuMingzi = {}
                local dangqianShijian = os.time()

                FirebaseHuoyueYonghu = {}
                if huoyueYonghu then
                    for userIdStr, info in pairs(huoyueYonghu) do
                        if info.timestamp and (dangqianShijian - info.timestamp) <= 60 then
                            FirebaseHuoyueYonghu[userIdStr] = info
                            table.insert(yonghuMingzi, info.username)
                        end
                    end

                    if Shezhi.ShowTags then
                        for _, player in ipairs(Wanjia:GetPlayers()) do
                            if FirebaseHuoyueYonghu[tostring(player.UserId)] or ShiGuanli(player.UserId) then
                                if not HuoyueBiaozhi[player] then
                                    yingyongToudingBiaozhi(player)
                                end
                            else
                                qingliBiaozhi(player)
                            end
                        end
                    end
                end

                if ShiGuanli(LocalPlayer.UserId) and WanjiaGundong then
                    for _, child in ipairs(WanjiaGundong:GetChildren()) do
                        if child:IsA("TextButton") or child:IsA("TextLabel") then
                            child:Destroy()
                        end
                    end

                    local count = 0
                    for userIdStr, info in pairs(FirebaseHuoyueYonghu) do
                        count = count + 1
                        local pBtn = Instance.new("TextButton")
                        pBtn.Size = UDim2.new(1, -5, 0, 30)
                        pBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                        pBtn.Text = " " .. info.username .. " (" .. userIdStr .. ")"
                        pBtn.TextColor3 = Yanse.GreyLight
                        pBtn.Font = Ziti.Bold
                        pBtn.TextSize = 12
                        pBtn.TextXAlignment = Enum.TextXAlignment.Left
                        pBtn.AutoButtonColor = false
                        pBtn.Parent = WanjiaGundong
                        chuangjianYuanjiao(pBtn, 4)
                        chuangjianMiaobian(pBtn, Yanse.Border, 1, 0.5)
                        BangdingJiaohuShengyin(pBtn)

                        pBtn.MouseEnter:Connect(function()
                            DonghuaFuwu:Create(pBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 35, 35), TextColor3 = Yanse.White}):Play()
                        end)
                        pBtn.MouseLeave:Connect(function()
                            DonghuaFuwu:Create(pBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 20, 20), TextColor3 = Yanse.GreyLight}):Play()
                        end)

                        pBtn.MouseButton1Click:Connect(function()
                            if setclipboard then
                                setclipboard(userIdStr)
                                pBtn.Text = " Copied ID to Clipboard!"
                                pBtn.TextColor3 = Color3.fromRGB(46, 125, 50)
                                task.wait(1.5)
                                if pBtn and pBtn.Parent then
                                    pBtn.Text = " " .. info.username .. " (" .. userIdStr .. ")"
                                    pBtn.TextColor3 = Yanse.White
                                end
                            end
                        end)
                    end

                    if count == 0 then
                        local kongBq = Instance.new("TextLabel")
                        kongBq.Size = UDim2.new(1, 0, 0, 30)
                        kongBq.BackgroundTransparency = 1
                        kongBq.Text = "No active users found."
                        kongBq.TextColor3 = Yanse.GreyMuted
                        kongBq.Font = Ziti.Medium
                        kongBq.TextSize = 12
                        kongBq.Parent = WanjiaGundong
                    end
                end
            end
        end
    end
end)

local function zhuchiWanjia(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if FirebaseHuoyueYonghu[tostring(player.UserId)] or ShiGuanli(player.UserId) then
            yingyongToudingBiaozhi(player)
        end
    end)
    if FirebaseHuoyueYonghu[tostring(player.UserId)] or ShiGuanli(player.UserId) then
        yingyongToudingBiaozhi(player)
    end
end

Wanjia.PlayerAdded:Connect(zhuchiWanjia)
Wanjia.PlayerRemoving:Connect(qingliBiaozhi)
for _, p in ipairs(Wanjia:GetPlayers()) do if p ~= LocalPlayer then zhuchiWanjia(p) end end
if ShiGuanli(LocalPlayer.UserId) then zhuchiWanjia(LocalPlayer) end

gengxinToudingKejian = function()
    if Shezhi.ShowTags then
        for _, p in ipairs(Wanjia:GetPlayers()) do
            if FirebaseHuoyueYonghu[tostring(p.UserId)] or ShiGuanli(p.UserId) then yingyongToudingBiaozhi(p) end
        end
    else
        for p, _ in pairs(HuoyueBiaozhi) do qingliBiaozhi(p) end
    end
end

YunxingFuwu.Heartbeat:Connect(function()
    local clock = tick()
    for player, data in pairs(HuoyueBiaozhi) do
        pcall(function()
            if data.Gui and data.TextLabel then
                if data.Rank == 4 or data.UserId == CHUANGZUOZHE_ID then
                    local gongshi = (math.sin(clock * 4.5) + 1) / 2
                    local zidingyiHong = Color3.fromRGB(229, 9, 20)
                    local zidingyiHei = Color3.fromRGB(15, 15, 15)
                    local chazhiYanse = zidingyiHei:Lerp(zidingyiHong, gongshi)
                    data.TextLabel.TextColor3 = chazhiYanse
                    data.Stroke.Color = chazhiYanse
                elseif data.Rank == 3 or (data.UserId == CO_CHUANGSHIREN_ID and data.Gradient) then
                    if data.Gradient then data.Gradient.Offset = Vector2.new(math.sin(clock * 1.5), 0) end
                    data.Stroke.Color = Color3.fromRGB(255, 215, 0)
                elseif data.Rank == 2 then
                    local gongshi = (math.sin(clock * 3.5) + 1) / 2
                    local nihongGuanli = Color3.fromRGB(180, 0, 255)
                    local anseGuanli = Color3.fromRGB(40, 0, 60)
                    local chazhiGuanli = anseGuanli:Lerp(nihongGuanli, gongshi)
                    data.TextLabel.TextColor3 = chazhiGuanli
                    data.Stroke.Color = chazhiGuanli
                else
                    local gongshi = (math.sin(clock * 3) + 1) / 2
                    local nihongJichu = Color3.fromRGB(0, 220, 255)
                    local anseJichu = Color3.fromRGB(0, 60, 80)
                    local chazhiGuangyun = anseJichu:Lerp(nihongJichu, gongshi)
                    data.TextLabel.TextColor3 = chazhiGuangyun
                    data.Stroke.Color = chazhiGuangyun
                end
            end
        end)
    end

    for _, player in ipairs(Wanjia:GetPlayers()) do
        if XunhuanJishaMubiao[player.UserId] and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then hum.Health = 0 end
        end
        if XuanzhuanMubiao[player.UserId] and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(25), 0)
            end
        end
    end
end)

gengxinDongtaiZhutiYanse(DangqianZhutiYanse)

-- 下面几段是后加的样式补丁 按顺序执行
function AnNetflixZhutiYingyong()

if not (ZhuKuangjia and BiaotouTiao and shiShouji2 and gengxinXiangkaHang) then
    warn("[AN Netflix theme] This file is not a standalone script. Paste its contents INTO your main AN Universal script (after updateDynamicThemeColors(CurrentThemeColor)), then run the main script.")
    return
end

local NF = {
    White   = Color3.fromRGB(255, 255, 255),
    Black   = Color3.fromRGB(0, 0, 0),
    Bg      = Color3.fromRGB(20, 20, 20),
    Nav     = Color3.fromRGB(10, 10, 10),
    Ink     = Color3.fromRGB(229, 229, 229),
    Muted   = Color3.fromRGB(179, 179, 179),
    Ghost   = Color3.fromRGB(109, 109, 110),
}

local function try(label, fn)
    local ok, err = pcall(fn)
    if not ok then warn("[AN Netflix theme] " .. label .. ": " .. tostring(err)) end
end

local function tween(obj, t, props, style, dir)
    DonghuaFuwu:Create(obj, TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props):Play()
end

local function quebao(parent, class, name)
    local o = parent:FindFirstChild(name)
    if not o then
        o = Instance.new(class)
        o.Name = name
        o.Parent = parent
    end
    return o
end

local function shezhiYuanjiao(obj, r)
    local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = obj
end

local shiShouji = shiShouji2()

try("window", function()
    ZhuKuangjia.BackgroundColor3 = NF.Bg
    shezhiYuanjiao(ZhuKuangjia, 8)

    BiaotouTiao.BackgroundColor3 = NF.Nav
    for _, c in ipairs(BiaotouTiao:GetChildren()) do

        if c:IsA("Frame") and c.Size.Y.Scale == 0 and c.Size.Y.Offset == 10 then
            c.BackgroundTransparency = 1
        end
    end
    local fade = quebao(BiaotouTiao, "UIGradient", "NFNavFade")
    fade.Rotation = 90
    fade.Transparency = NumberSequence.new(0, 0.55)
end)

try("wordmark", function()
    PinpaiLogo.TextSize = 22
    local g = quebao(PinpaiLogo, "UIGradient", "NFWordmarkShine")
    g.Rotation = 90
    g.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(165, 165, 165))
end)

local daohangXiangka = {DianyingXiangka, ZhixingqiXiangka, DaobanXiangka, ShezhiXiangka, MingdanXiangka}
if GuanliXiangka then table.insert(daohangXiangka, GuanliXiangka) end

try("tabs", function()
    for _, tab in ipairs(daohangXiangka) do
        tab.Size = UDim2.new(0, tab.Size.X.Offset + 6, 0, shiShouji and 36 or 30)
        tab.TextSize = 13
        tab.TextColor3 = NF.Muted
        tab.MouseEnter:Connect(function()
            if not tab:GetAttribute("ANActive") then tween(tab, 0.12, {TextColor3 = NF.White}) end
        end)
        tab.MouseLeave:Connect(function()
            if not tab:GetAttribute("ANActive") then tween(tab, 0.12, {TextColor3 = NF.Muted}) end
        end)
    end

    local yuanGengxinXiangkaHang = gengxinXiangkaHang
    gengxinXiangkaHang = function(targetTab)
        yuanGengxinXiangkaHang(targetTab)
        for _, tab in ipairs(daohangXiangka) do
            local huoyue = (tab == targetTab)
            tab:SetAttribute("ANActive", huoyue)
            tab.Font = huoyue and Ziti.Bold or Ziti.Medium
            tween(tab, 0.2, {TextColor3 = huoyue and NF.White or NF.Muted})
        end
    end
end)

try("filters", function()
    FenleiBtn.BackgroundColor3 = NF.Black
    local gMiaobian = FenleiBtn:FindFirstChildOfClass("UIStroke")
    if gMiaobian then gMiaobian.Color = NF.Ghost; gMiaobian.Transparency = 0.1 end

    local sousuoKuangjia = SousuoKuang.Parent
    sousuoKuangjia.BackgroundColor3 = NF.Black
    local sMiaobian = sousuoKuangjia:FindFirstChildOfClass("UIStroke")
    if sMiaobian then sMiaobian.Color = NF.Ghost; sMiaobian.Transparency = 0.25 end

    SousuoKuang.Focused:Connect(function()
        sousuoKuangjia.BackgroundColor3 = NF.Black
        if sMiaobian then tween(sMiaobian, 0.15, {Color = NF.White, Transparency = 0}) end
    end)
    SousuoKuang.FocusLost:Connect(function()
        sousuoKuangjia.BackgroundColor3 = NF.Black
        if sMiaobian then tween(sMiaobian, 0.15, {Color = NF.Ghost, Transparency = 0.25}) end
    end)
end)

local PaiBiaoti
try("arrows + row title", function()
    for _, arrow in ipairs({ZuoJiantou, YouJiantou}) do
        local you = (arrow.Name == "RightArrow")
        arrow.AnchorPoint = Vector2.new(you and 1 or 0, 0)
        arrow.Position = UDim2.new(you and 1 or 0, 0, 0, 0)
        arrow.Size = UDim2.new(0, shiShouji and 36 or 34, 1, 0)
        arrow.BackgroundColor3 = NF.Black
        arrow.BackgroundTransparency = 0.45
        arrow.TextColor3 = NF.White
        arrow.TextSize = 24
        arrow.Font = Ziti.Bold
        shezhiYuanjiao(arrow, 4)
        local st = arrow:FindFirstChildOfClass("UIStroke")
        if st then st:Destroy() end
        arrow.MouseEnter:Connect(function() tween(arrow, 0.12, {BackgroundTransparency = 0.15}) end)
        arrow.MouseLeave:Connect(function() tween(arrow, 0.12, {BackgroundTransparency = 0.45}) end)
    end

    PaiBiaoti = quebao(LunboRongqi, "TextLabel", "NFRowTitle")
    PaiBiaoti.BackgroundTransparency = 1
    PaiBiaoti.Size = UDim2.new(1, -90, 0, 20)
    PaiBiaoti.Position = UDim2.new(0, 44, 0, 1)
    PaiBiaoti.Font = Ziti.Bold
    PaiBiaoti.TextSize = 15
    PaiBiaoti.TextColor3 = NF.Ink
    PaiBiaoti.TextXAlignment = Enum.TextXAlignment.Left
    PaiBiaoti.ZIndex = 9
    PaiBiaoti.Text = "All Titles"

    local function tongbuPaiBiaoti()
        PaiBiaoti.Visible = LunboRongqi.AbsoluteSize.Y >= 250
    end
    tongbuPaiBiaoti()
    LunboRongqi:GetPropertyChangedSignal("AbsoluteSize"):Connect(tongbuPaiBiaoti)
end)

local function zhuangshiKapian()
    for _, card in ipairs(DianyingLunbo:GetChildren()) do
        if card:IsA("Frame") then
            local idx = tonumber(card.Name:match("^Card_(%d+)$"))
            local haibao = card:FindFirstChild("PosterImg")
            local dianying = idx and kejianDianying[idx]
            if haibao and dianying and not haibao:FindFirstChild("NFRing") then
                shezhiYuanjiao(haibao, 4)

                local ring = Instance.new("UIStroke")
                ring.Name = "NFRing"
                ring.Color = NF.White
                ring.Thickness = 2
                ring.Transparency = 1
                ring.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                ring.Parent = haibao

                local cap = Instance.new("Frame")
                cap.Name = "NFCaption"
                cap.AnchorPoint = Vector2.new(0, 1)
                cap.Position = UDim2.new(0, 0, 1, 0)
                cap.Size = UDim2.new(1, 0, 0, 54)
                cap.BackgroundColor3 = NF.Black
                cap.BackgroundTransparency = 1
                cap.BorderSizePixel = 0
                cap.ZIndex = 5
                cap.Parent = haibao
                shezhiYuanjiao(cap, 4)

                local zhezhaoceng = Instance.new("UIGradient")
                zhezhaoceng.Rotation = 90
                zhezhaoceng.Transparency = NumberSequence.new(1, 0.02)
                zhezhaoceng.Parent = cap

                local title = Instance.new("TextLabel")
                title.Name = "NFTitle"
                title.BackgroundTransparency = 1
                title.Size = UDim2.new(1, -12, 1, -8)
                title.Position = UDim2.new(0, 6, 0, 0)
                title.Font = Ziti.Bold
                title.TextSize = 11
                title.TextColor3 = NF.White
                title.TextTransparency = 1
                title.TextWrapped = true
                title.TextTruncate = Enum.TextTruncate.AtEnd
                title.TextXAlignment = Enum.TextXAlignment.Left
                title.TextYAlignment = Enum.TextYAlignment.Bottom
                title.Text = tostring(dianying.Title or "")
                title.ZIndex = 6
                title.Parent = cap

                local huizhang = Instance.new("TextLabel")
                huizhang.Name = "NFBadge"
                huizhang.Size = UDim2.new(0, 22, 0, 14)
                huizhang.Position = UDim2.new(0, 4, 0, 4)
                huizhang.BackgroundColor3 = Yanse.BrandRed
                huizhang.BorderSizePixel = 0
                huizhang.Text = "AN"
                huizhang.TextColor3 = NF.White
                huizhang.Font = Ziti.Heavy
                huizhang.TextSize = 9
                huizhang.ZIndex = 5
                huizhang.Parent = haibao
                shezhiYuanjiao(huizhang, 2)
            end
        end
    end
end

local function shuaxinZhezhao()
    for _, card in ipairs(DianyingLunbo:GetChildren()) do
        if card:IsA("Frame") then
            local idx = tonumber(card.Name:match("^Card_(%d+)$"))
            local haibao = card:FindFirstChild("PosterImg")
            if idx and haibao then
                local zhongxin = (idx == dangqianSuoyin)
                local ring = haibao:FindFirstChild("NFRing")
                local cap = haibao:FindFirstChild("NFCaption")
                if ring then tween(ring, 0.2, {Transparency = zhongxin and 0 or 1}) end
                if cap then
                    tween(cap, 0.25, {BackgroundTransparency = zhongxin and 0 or 1})
                    local t = cap:FindFirstChild("NFTitle")
                    if t then tween(t, 0.25, {TextTransparency = zhongxin and 0 or 1}) end
                end
            end
        end
    end
end

try("card hooks", function()
    local yuanBuju = bujuKapian
    bujuKapian = function(instant)
        yuanBuju(instant)
        pcall(zhuangshiKapian)
        pcall(shuaxinZhezhao)
    end

    local yuanYuandian = gengxinYuandian
    gengxinYuandian = function()
        yuanYuandian()
        for _, d in ipairs(YuandianRongna:GetChildren()) do
            if d:IsA("Frame") then
                local huoyue = d.Size.X.Offset > 10
                d.Size = UDim2.new(0, huoyue and 22 or 8, 0, 3)
            end
        end
    end

    local yuanGengxinLunbo = gengxinLunbo
    gengxinLunbo = function()
        if yuanGengxinLunbo then yuanGengxinLunbo() end
        if PaiBiaoti then
            local name = (DangqianFenlei == "All") and "All Titles" or DangqianFenlei
            PaiBiaoti.Text = name .. "  ·  " .. tostring(#kejianDianying)
        end
    end
end)

try("detail", function()
    local glow = quebao(XiangqingKuangjia, "Frame", "NFHeroGlow")
    glow.Size = UDim2.new(1, 0, 1, 0)
    glow.BackgroundColor3 = Yanse.BrandRed
    glow.BorderSizePixel = 0
    glow.ZIndex = 0
    local gg = quebao(glow, "UIGradient", "NFGlowGradient")
    gg.Rotation = 35
    gg.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.84),
        NumberSequenceKeypoint.new(0.55, 1),
        NumberSequenceKeypoint.new(1, 1),
    })

    shezhiYuanjiao(XiangqingTupian, 4)
    XiangqingBiaoti.TextSize = shiShouji and 20 or 26
    YuanxinxiPai.TextColor3 = NF.Muted
    XiangqingMiaoshu.TextColor3 = NF.Ink
    XiangqingMiaoshu.LineHeight = 1.15
end)

local function yangshiXiangqingAnniu()
    BofangBtn.BackgroundColor3 = NF.White
    BofangBtn.TextColor3 = NF.Black
    BofangBtn.Font = Ziti.Bold
    BofangBtn.TextSize = 14

    for _, b in ipairs({ShoucangBtn, FanhuiBtn}) do
        b.BackgroundColor3 = NF.Ghost
        b.BackgroundTransparency = 0.3
        b.TextColor3 = NF.White
    end
end

try("detail buttons", function()
    yangshiXiangqingAnniu()

    BofangBtn.MouseEnter:Connect(function() tween(BofangBtn, 0.12, {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}) end)
    BofangBtn.MouseLeave:Connect(function() tween(BofangBtn, 0.12, {BackgroundColor3 = NF.White}) end)
    for _, b in ipairs({ShoucangBtn, FanhuiBtn}) do
        b.MouseEnter:Connect(function() tween(b, 0.12, {BackgroundColor3 = NF.Ghost, BackgroundTransparency = 0.55}) end)
        b.MouseLeave:Connect(function() tween(b, 0.12, {BackgroundColor3 = NF.Ghost, BackgroundTransparency = 0.3}) end)
    end

    local yuanZhuti = gengxinDongtaiZhutiYanse
    gengxinDongtaiZhutiYanse = function(newColor)
        yuanZhuti(newColor)
        pcall(yangshiXiangqingAnniu)
    end
end)

end

AnNetflixZhutiYingyong()

function AnNetflixZiti()

local huodeZiyuan = getcustomasset or getsynasset
if not (PingmuJiemian and writefile and isfile and readfile and huodeZiyuan and Font and Font.new) then
    warn("[AN Netflix fonts] Executor lacks custom font support - keeping default fonts.")
    return
end

local BASE = "https://github.com/GUICLOUDS/LRC/raw/refs/heads/main/"
local Guige = {
    Bebas     = {file = "BebasNeue-Regular.otf",                     ext = "otf", num = 400, weight = Enum.FontWeight.Regular},
    FigBold   = {file = "Figtree-Bold.ttf",                          ext = "ttf", num = 700, weight = Enum.FontWeight.Bold},
    FigMedium = {file = "Figtree-Medium.ttf",                        ext = "ttf", num = 500, weight = Enum.FontWeight.Medium},
    FigReg    = {file = "Figtree-Regular.ttf",                       ext = "ttf", num = 400, weight = Enum.FontWeight.Regular},
    Mono      = {file = "jetbrains-mono-regular-6_ufonts.com.ttf",   ext = "ttf", num = 400, weight = Enum.FontWeight.Regular},
}

local MEIJU_YINGSHE = {
    [Enum.Font.GothamBlack]       = "FigBold",
    [Enum.Font.GothamBold]        = "FigBold",
    [Enum.Font.GothamMedium]      = "FigMedium",
    [Enum.Font.Gotham]            = "FigReg",
    [Enum.Font.SourceSans]        = "FigReg",
    [Enum.Font.SourceSansSemibold]= "FigMedium",
    [Enum.Font.SourceSansBold]    = "FigBold",
    [Enum.Font.Code]              = "Mono",
}

local yijiazai = {}

local function youxiaoZiti(d)
    if type(d) ~= "string" or #d < 4096 then return false end
    local m = d:sub(1, 4)
    return m == "\0\1\0\0" or m == "OTTO" or m == "true" or m == "ttcf"
end

local function huoqu(url)
    if httpQingqiu then
        local ok, res = pcall(httpQingqiu, {Url = url, Method = "GET"})
        if ok and res and type(res.Body) == "string" then
            local code = tonumber(res.StatusCode or res.status_code)
            if not code or code == 200 then return res.Body end
        end
    end
    local ok, body = pcall(function() return game:HttpGet(url) end)
    return ok and body or nil
end

local function jiazaiYi(key, spec)
    local path = "AN/NFX_FONT_" .. key .. "." .. spec.ext
    local data
    if isfile(path) then
        local okDuqu, cached = pcall(readfile, path)
        if okDuqu and youxiaoZiti(cached) then data = cached end
    end
    if not data then
        local body = huoqu(BASE .. spec.file)
        if not youxiaoZiti(body) then return end
        data = body
        if not pcall(writefile, path, data) then return end
    end

    local ok, font = pcall(function()
        local jsonLujing = "AN/NFX_FONT_" .. key .. ".json"
        writefile(jsonLujing, HttpFuwu:JSONEncode({
            name = "AN" .. key,
            faces = {{name = "Regular", weight = spec.num, style = "normal", assetId = huodeZiyuan(path)}}
        }))
        return Font.new(huodeZiyuan(jsonLujing), spec.weight, Enum.FontStyle.Normal)
    end)
    if ok and font then yijiazai[key] = font end
end

local function shiWenbenDuixiang(o)
    return o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox")
end

local function gouziWenben(obj)
    if not shiWenbenDuixiang(obj) then return end
    local busy = false
    local function yingyong()
        if busy then return end
        local key = obj:GetAttribute("ANFace") or MEIJU_YINGSHE[obj.Font]
        local face = key and yijiazai[key]
        if face then
            busy = true
            pcall(function() obj.FontFace = face end)
            busy = false
        end
    end
    yingyong()
    if not obj:GetAttribute("ANFontHooked") then
        obj:SetAttribute("ANFontHooked", true)
        obj:GetPropertyChangedSignal("Font"):Connect(yingyong)
    end
end

task.spawn(function()

    local pending = 0
    for key, spec in pairs(Guige) do
        pending = pending + 1
        task.spawn(function()
            pcall(jiazaiYi, key, spec)
            pending = pending - 1
        end)
    end
    local dengdai = 0
    while pending > 0 and dengdai < 20 do task.wait(0.1); dengdai = dengdai + 0.1 end

    if next(yijiazai) == nil then
        warn("[AN Netflix fonts] No fonts could be loaded - keeping default fonts.")
        return
    end

    if yijiazai.Bebas then
        local bebasMubiao = {PinpaiLogo, XiangqingBiaoti, MingdanDaN, PingmuJiemian:FindFirstChild("NFRowTitle", true)}
        for _, obj in ipairs(bebasMubiao) do
            if obj and not obj:GetAttribute("ANBebasScaled") then
                obj:SetAttribute("ANBebasScaled", true)
                obj:SetAttribute("ANFace", "Bebas")
                obj.TextSize = math.floor(obj.TextSize * 1.3)
            end
        end
    end

    for _, d in ipairs(PingmuJiemian:GetDescendants()) do gouziWenben(d) end

    PingmuJiemian.DescendantAdded:Connect(function(d) task.defer(gouziWenben, d) end)
end)

end

AnNetflixZiti()

function AnNetflixZishiying()

if not (ZhuKuangjia and huodeMubiaoDaxiao and pingyiLunbo and shituXiangqingPingmu and luyouDaoShitu and LunboRongqi) then
    warn("[AN Netflix responsive] Paste this INTO the main script after ANNetflixFonts().")
    return
end

local shiShouji = shiShouji2()

local function try(label, fn)
    local ok, err = pcall(fn)
    if not ok then warn("[AN Netflix responsive] " .. label .. ": " .. tostring(err)) end
end

try("window size", function()
    huodeMubiaoDaxiao = function()
        local vp = Xiangji.ViewportSize
        local w, h
        if shiShouji2() then
            w = math.min(vp.X - 32, 720)
            h = math.min(vp.Y - 24, 440)
        else
            w = math.min(ChuangkouPeizhi.Width, vp.X - 24)
            h = math.min(ChuangkouPeizhi.Height, vp.Y - 24)
        end
        return UDim2.new(0, math.max(w, 480), 0, math.max(h, 280))
    end

    local s = huodeMubiaoDaxiao()
    ZhuKuangjia.Size = s
    ZhuKuangjia.Position = UDim2.new(0.5, -s.X.Offset / 2, 0.5, -s.Y.Offset / 2)
    huancunChuangkouZuobiao = ZhuKuangjia.Position
end)

if shiShouji then
    try("touch targets", function()
        local shaixuanPai = FenleiBtn.Parent
        if shaixuanPai then shaixuanPai.Size = UDim2.new(1, -36, 0, 40) end

        FenleiXiala.Size = UDim2.new(0, 150, 0, 170)
        for _, b in ipairs(FenleiXiala:GetChildren()) do
            if b:IsA("TextButton") then
                b.Size = UDim2.new(1, -6, 0, 34)
                b.TextSize = 13
            end
        end

        SuoxiaoBtn.Size = UDim2.new(0, 32, 0, 32)
        local mc = SuoxiaoBtn:FindFirstChildOfClass("UICorner")
        if mc then mc.CornerRadius = UDim.new(0, 16) end
        SuoxiaoBtn.TextSize = 16
    end)

    try("min text size", function()
        local function bump(o)
            if (o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox"))
                and not o.TextScaled and o.TextSize < 10 then
                o.TextSize = 10
            end
        end
        for _, d in ipairs(PingmuJiemian:GetDescendants()) do bump(d) end
        PingmuJiemian.DescendantAdded:Connect(function(d) task.defer(bump, d) end)
    end)
end

try("swipe", function()
    local chumo = {}

    local function zaineiLunbo(p)
        local a, s = LunboRongqi.AbsolutePosition, LunboRongqi.AbsoluteSize
        local neisuo = JiemianFuwu:GetGuiInset().Y
        local function hit(y) return p.X >= a.X and p.X <= a.X + s.X and y >= a.Y and y <= a.Y + s.Y end
        return hit(p.Y) or hit(p.Y + neisuo)
    end

    local function yizhiDianji()
        for _, card in ipairs(DianyingLunbo:GetChildren()) do
            local b = card:FindFirstChildOfClass("TextButton")
            if b then b.Active = false end
        end
        task.delay(0.4, function()
            for _, card in ipairs(DianyingLunbo:GetChildren()) do
                local b = card:FindFirstChildOfClass("TextButton")
                if b then b.Active = true end
            end
        end)
    end

    YonghuShuruFuwu.TouchStarted:Connect(function(t)
        if huoyueShitu ~= "menu" or not ZhuKuangjia.Visible then return end
        if zaineiLunbo(t.Position) then
            chumo[t] = {x = t.Position.X, y = t.Position.Y, done = false}
        end
    end)

    YonghuShuruFuwu.TouchMoved:Connect(function(t)
        local rec = chumo[t]
        if not rec or rec.done then return end
        local dx, dy = t.Position.X - rec.x, t.Position.Y - rec.y
        if math.abs(dx) > 48 and math.abs(dx) > math.abs(dy) * 1.5 then
            rec.done = true
            yizhiDianji()
            pingyiLunbo(dx < 0 and 1 or -1)
        end
    end)

    YonghuShuruFuwu.TouchEnded:Connect(function(t) chumo[t] = nil end)
end)

try("keyboard + gamepad", function()
    local K = Enum.KeyCode
    local function dakaiZhongxin()
        local dianying = kejianDianying[dangqianSuoyin]
        if not dianying then return end
        if dianying.Kind == "pirated" and shituDaobanShoucangXiangqing then
            shituDaobanShoucangXiangqing(dianying)
        else
            shituXiangqingPingmu(dianying)
        end
    end

    YonghuShuruFuwu.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed or not ZhuKuangjia.Visible then return end
        local k = input.KeyCode
        if huoyueShitu == "menu" then
            if k == K.Left or k == K.DPadLeft then
                pingyiLunbo(-1)
            elseif k == K.Right or k == K.DPadRight then
                pingyiLunbo(1)
            elseif k == K.Return or k == K.KeypadEnter or k == K.ButtonA then
                dakaiZhongxin()
            end
        elseif huoyueShitu == "detail" then
            if k == K.Backspace or k == K.ButtonB then
                qingkongDaobanTupianHuancun()
                luyouDaoShitu("menu")
                gengxinXiangkaHang(DianyingXiangka)
            end
        end
    end)
end)

try("pirated grid", function()
    if not (PiratedResults and PiratedGrid) then return end

    local function yingyongWangge()
        local gap = 10
        local zuixiaoDanyuan = shiShouji2() and 300 or 205
        local kuandu = PiratedResults.AbsoluteSize.X - 8
        if kuandu <= 0 then return end
        local cols = math.clamp(math.floor((kuandu + gap) / (zuixiaoDanyuan + gap)), 1, 3)
        local danyuanW = math.floor((kuandu - gap * (cols - 1)) / cols)
        PiratedGrid.CellPadding = UDim2.new(0, gap, 0, gap)
        PiratedGrid.CellSize = UDim2.new(0, danyuanW, 0, shiShouji2() and 168 or 184)
    end

    yingyongWangge()
    PiratedResults:GetPropertyChangedSignal("AbsoluteSize"):Connect(yingyongWangge)

    Xiangji:GetPropertyChangedSignal("ViewportSize"):Connect(function() task.defer(yingyongWangge) end)
end)

end

AnNetflixZishiying()

function AnNetflixDaoban()

if not (ZhuKuangjia and luyouDaoShitu and DaobanKuangjia and Shezhi and baocunShezhi
        and ShezhiGundong and gengxinXiangkaHang and DianyingXiangka) then
    warn("[AN Netflix pirated] Paste this INTO the main script after ANNetflixResponsive().")
    return
end

local DaobanXiangqing = DaobanKuangjia:FindFirstChild("PiratedDetail")
if not DaobanXiangqing then
    warn("[AN Netflix pirated] PiratedDetail not found - skipping.")
    return
end

local NF = {
    White = Color3.fromRGB(255, 255, 255),
    Black = Color3.fromRGB(0, 0, 0),
    Ink   = Color3.fromRGB(229, 229, 229),
    Muted = Color3.fromRGB(179, 179, 179),
    Ghost = Color3.fromRGB(109, 109, 110),
    Card  = Color3.fromRGB(24, 24, 24),
    Green = Color3.fromRGB(46, 125, 50),
    Red   = Color3.fromRGB(198, 40, 40),
}

local function try(label, fn)
    local ok, err = pcall(fn)
    if not ok then warn("[AN Netflix pirated] " .. label .. ": " .. tostring(err)) end
end

local function tween(obj, t, props, style, dir)
    DonghuaFuwu:Create(obj, TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props):Play()
end

local function shezhiYuanjiao(obj, r)
    local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = obj
end

local function tianjiaMiaobian(obj, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = obj
    return s
end

local function tishi(text)
    local t = Instance.new("TextLabel")
    t.AutomaticSize = Enum.AutomaticSize.X
    t.Size = UDim2.new(0, 0, 0, 34)
    t.AnchorPoint = Vector2.new(0.5, 1)
    t.Position = UDim2.new(0.5, 0, 1, 40)
    t.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    t.TextColor3 = NF.White
    t.Font = Ziti.Bold
    t.TextSize = 12
    t.Text = text
    t.ZIndex = 250
    t.Parent = ZhuKuangjia
    shezhiYuanjiao(t, 17)
    tianjiaMiaobian(t, Color3.fromRGB(70, 70, 70), 1, 0.2)
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 16)
    pad.PaddingRight = UDim.new(0, 16)
    pad.Parent = t
    tween(t, 0.25, {Position = UDim2.new(0.5, 0, 1, -16)}, Enum.EasingStyle.Cubic)
    task.delay(1.8, function()
        if not t.Parent then return end
        tween(t, 0.2, {Position = UDim2.new(0.5, 0, 1, 40)})
        task.delay(0.22, function() if t.Parent then t:Destroy() end end)
    end)
end

local tiaokuanDakai = false
local huihuaYijieshou = false

local function zhanshiTiaokuan()
    if tiaokuanDakai then return end
    tiaokuanDakai = true

    local W = math.min(440, ZhuKuangjia.AbsoluteSize.X - 32)
    local H = math.min(350, ZhuKuangjia.AbsoluteSize.Y - 24)

    local zhezhao = Instance.new("Frame")
    zhezhao.Name = "NFTermsOverlay"
    zhezhao.Size = UDim2.new(1, 0, 1, 0)
    zhezhao.BackgroundColor3 = NF.Black
    zhezhao.BackgroundTransparency = 1
    zhezhao.BorderSizePixel = 0
    zhezhao.Active = true
    zhezhao.ZIndex = 400
    zhezhao.Parent = ZhuKuangjia
    shezhiYuanjiao(zhezhao, 10)
    tween(zhezhao, 0.18, {BackgroundTransparency = 0.3})

    local card = Instance.new("Frame")
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Position = UDim2.new(0.5, 0, 0.5, 0)
    card.Size = UDim2.new(0, W, 0, H)
    card.BackgroundColor3 = NF.Card
    card.BorderSizePixel = 0
    card.ZIndex = 401
    card.Parent = zhezhao
    shezhiYuanjiao(card, 8)
    tianjiaMiaobian(card, Color3.fromRGB(60, 60, 60), 1, 0.2)

    local suofang = Instance.new("UIScale")
    suofang.Scale = 0.94
    suofang.Parent = card
    tween(suofang, 0.2, {Scale = 1}, Enum.EasingStyle.Cubic)

    local xiaobiaoti = Instance.new("TextLabel")
    xiaobiaoti.BackgroundTransparency = 1
    xiaobiaoti.Position = UDim2.new(0, 16, 0, 14)
    xiaobiaoti.Size = UDim2.new(1, -32, 0, 14)
    xiaobiaoti.Font = Ziti.Bold
    xiaobiaoti.TextSize = 10
    xiaobiaoti.TextColor3 = Yanse.BrandRed
    xiaobiaoti.TextXAlignment = Enum.TextXAlignment.Left
    xiaobiaoti.Text = "THIRD-PARTY SCRIPTS"
    xiaobiaoti.ZIndex = 402
    xiaobiaoti.Parent = card

    local dabiaoti = Instance.new("TextLabel")
    dabiaoti.BackgroundTransparency = 1
    dabiaoti.Position = UDim2.new(0, 16, 0, 28)
    dabiaoti.Size = UDim2.new(1, -32, 0, 28)
    dabiaoti.Font = Ziti.Heavy
    dabiaoti.TextSize = 20
    dabiaoti.TextColor3 = NF.White
    dabiaoti.TextXAlignment = Enum.TextXAlignment.Left
    dabiaoti.Text = "Terms & Agreement"
    dabiaoti.ZIndex = 402
    dabiaoti.Parent = card

    local body = Instance.new("ScrollingFrame")
    body.BackgroundTransparency = 1
    body.BorderSizePixel = 0
    body.Position = UDim2.new(0, 16, 0, 64)
    body.Size = UDim2.new(1, -32, 1, -166)
    body.ScrollBarThickness = 3
    body.ScrollBarImageColor3 = Yanse.BrandRed
    body.CanvasSize = UDim2.new(0, 0, 0, 0)
    body.AutomaticCanvasSize = Enum.AutomaticSize.Y
    body.ScrollingDirection = Enum.ScrollingDirection.Y
    body.ZIndex = 402
    body.Parent = card

    local zhengwenBuju = Instance.new("UIListLayout")
    zhengwenBuju.Padding = UDim.new(0, 8)
    zhengwenBuju.SortOrder = Enum.SortOrder.LayoutOrder
    zhengwenBuju.Parent = body

    local duanluo = {
        {"Scripts in the Pirated section are made by other people and hosted on third-party sites. AN Universal does not write, review or control them.", NF.Ink},
        {"By continuing, you accept that AN Universal and its team are not responsible if your account, device or data is compromised, or if a script adds or changes files in your executor's workspace without you knowing.", NF.Ink},
        {"Only run scripts from creators you trust, and check what a script does before you execute it.", NF.Muted},
    }
    for i, p in ipairs(duanluo) do
        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.AutomaticSize = Enum.AutomaticSize.Y
        lbl.Size = UDim2.new(1, -8, 0, 0)
        lbl.Font = Ziti.Book
        lbl.TextSize = 13
        lbl.TextColor3 = p[2]
        lbl.TextWrapped = true
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextYAlignment = Enum.TextYAlignment.Top
        lbl.Text = p[1]
        lbl.LayoutOrder = i
        lbl.ZIndex = 403
        lbl.Parent = body
    end

    local gouxuan = false
    local row = Instance.new("TextButton")
    row.Text = ""
    row.AutoButtonColor = false
    row.BackgroundTransparency = 1
    row.AnchorPoint = Vector2.new(0, 1)
    row.Position = UDim2.new(0, 16, 1, -66)
    row.Size = UDim2.new(1, -32, 0, 34)
    row.ZIndex = 402
    row.Parent = card
    BangdingJiaohuShengyin(row)

    local box = Instance.new("Frame")
    box.Size = UDim2.new(0, 20, 0, 20)
    box.Position = UDim2.new(0, 0, 0.5, -10)
    box.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    box.BorderSizePixel = 0
    box.ZIndex = 403
    box.Parent = row
    shezhiYuanjiao(box, 4)
    local kuangMiaobian = tianjiaMiaobian(box, NF.Ghost, 1.5, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 12, 0, 12)
    fill.Position = UDim2.new(0.5, -6, 0.5, -6)
    fill.BackgroundColor3 = Yanse.BrandRed
    fill.BorderSizePixel = 0
    fill.Visible = false
    fill.ZIndex = 404
    fill.Parent = box
    shezhiYuanjiao(fill, 2)

    local paiBiaoqian = Instance.new("TextLabel")
    paiBiaoqian.BackgroundTransparency = 1
    paiBiaoqian.Position = UDim2.new(0, 30, 0, 0)
    paiBiaoqian.Size = UDim2.new(1, -30, 1, 0)
    paiBiaoqian.Font = Ziti.Medium
    paiBiaoqian.TextSize = 13
    paiBiaoqian.TextColor3 = NF.Muted
    paiBiaoqian.TextXAlignment = Enum.TextXAlignment.Left
    paiBiaoqian.Text = "Don't show this again"
    paiBiaoqian.ZIndex = 403
    paiBiaoqian.Parent = row

    row.MouseButton1Click:Connect(function()
        gouxuan = not gouxuan
        fill.Visible = gouxuan
        kuangMiaobian.Color = gouxuan and NF.White or NF.Ghost
        paiBiaoqian.TextColor3 = gouxuan and NF.White or NF.Muted
    end)

    local btnPai = Instance.new("Frame")
    btnPai.BackgroundTransparency = 1
    btnPai.AnchorPoint = Vector2.new(0, 1)
    btnPai.Position = UDim2.new(0, 16, 1, -16)
    btnPai.Size = UDim2.new(1, -32, 0, 42)
    btnPai.ZIndex = 402
    btnPai.Parent = card

    local jieshou = Instance.new("TextButton")
    jieshou.Size = UDim2.new(0.58, -4, 1, 0)
    jieshou.BackgroundColor3 = NF.White
    jieshou.TextColor3 = NF.Black
    jieshou.Font = Ziti.Bold
    jieshou.TextSize = 14
    jieshou.Text = "I Understand"
    jieshou.AutoButtonColor = false
    jieshou.ZIndex = 403
    jieshou.Parent = btnPai
    shezhiYuanjiao(jieshou, 4)
    BangdingJiaohuShengyin(jieshou)

    local jujue = Instance.new("TextButton")
    jujue.Size = UDim2.new(0.42, -4, 1, 0)
    jujue.Position = UDim2.new(0.58, 4, 0, 0)
    jujue.BackgroundColor3 = NF.Ghost
    jujue.BackgroundTransparency = 0.3
    jujue.TextColor3 = NF.White
    jujue.Font = Ziti.Bold
    jujue.TextSize = 13
    jujue.Text = "Go Back"
    jujue.AutoButtonColor = false
    jujue.ZIndex = 403
    jujue.Parent = btnPai
    shezhiYuanjiao(jujue, 4)
    BangdingJiaohuShengyin(jujue)

    jieshou.MouseEnter:Connect(function() tween(jieshou, 0.12, {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}) end)
    jieshou.MouseLeave:Connect(function() tween(jieshou, 0.12, {BackgroundColor3 = NF.White}) end)
    jujue.MouseEnter:Connect(function() tween(jujue, 0.12, {BackgroundTransparency = 0.55}) end)
    jujue.MouseLeave:Connect(function() tween(jujue, 0.12, {BackgroundTransparency = 0.3}) end)

    local wancheng = false
    local function guanbi(afterClose)
        if wancheng then return end
        wancheng = true
        tween(zhezhao, 0.15, {BackgroundTransparency = 1})
        tween(suofang, 0.15, {Scale = 0.96})
        task.delay(0.16, function()
            if zhezhao.Parent then zhezhao:Destroy() end
            tiaokuanDakai = false
            if afterClose then afterClose() end
        end)
    end

    jieshou.MouseButton1Click:Connect(function()
        if gouxuan then
            Shezhi.HidePiratedTerms = true
            baocunShezhi()
        end
        huihuaYijieshou = true
        guanbi()
    end)

    jujue.MouseButton1Click:Connect(function()
        guanbi(function()
            luyouDaoShitu("menu")
            gengxinXiangkaHang(DianyingXiangka)
        end)
    end)
end

try("terms gate", function()

    local yuanLuyou = luyouDaoShitu
    luyouDaoShitu = function(viewName)
        yuanLuyou(viewName)
        if viewName == "pirated" and not Shezhi.HidePiratedTerms and not huihuaYijieshou then
            zhanshiTiaokuan()
        end
    end
end)

try("settings switch", function()
    local SUI = AN_HUANJING.AN_SettingsUI
    local card = SUI and SUI.card and SUI.card["General"]
    if card then
        local sw = SUI.switchRow(card, "Pirated terms notice", "Show the usage notice when you open Pirated", Shezhi.HidePiratedTerms ~= true)
        sw.MouseButton1Click:Connect(function()
            Shezhi.HidePiratedTerms = not (Shezhi.HidePiratedTerms == true)
            baocunShezhi()
            SUI.setSwitch(sw, Shezhi.HidePiratedTerms ~= true)
        end)
        SUI.syncs[#SUI.syncs + 1] = function()
            SUI.setSwitch(sw, Shezhi.HidePiratedTerms ~= true, true)
        end
        return
    end

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -12, 0, 44)
    row.BackgroundColor3 = Yanse.DarkCard
    row.BorderSizePixel = 0
    row.LayoutOrder = 100
    row.Parent = ShezhiGundong
    shezhiYuanjiao(row, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.55, 0, 1, 0)
    lbl.Position = UDim2.new(0, 16, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Pirated Terms Notice"
    lbl.TextColor3 = Yanse.White
    lbl.Font = Ziti.Bold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 110, 0, 30)
    btn.Position = UDim2.new(1, -126, 0.5, -15)
    btn.Font = Ziti.Bold
    btn.TextSize = 12
    btn.TextColor3 = Yanse.White
    btn.AutoButtonColor = false
    btn.Parent = row
    shezhiYuanjiao(btn, 4)
    BangdingJiaohuShengyin(btn)

    local function sync()
        local yincang = Shezhi.HidePiratedTerms == true
        btn.Text = yincang and "Hidden" or "Shown"
        btn.BackgroundColor3 = yincang and NF.Red or NF.Green
    end
    sync()
    btn.MouseButton1Click:Connect(function()
        Shezhi.HidePiratedTerms = not (Shezhi.HidePiratedTerms == true)
        baocunShezhi()
        sync()
    end)
end)

local hengfu, hengfuZhengwen

try("detail layout + banner", function()

    if not DaobanXiangqing:GetAttribute("NFOrdered") then
        DaobanXiangqing:SetAttribute("NFOrdered", true)
        for _, c in ipairs(DaobanXiangqing:GetChildren()) do
            if c:IsA("GuiObject") then
                if c:IsA("TextLabel") and c.Text == "CREATOR TAGS" then
                    c.LayoutOrder = 35
                else
                    c.LayoutOrder = c.LayoutOrder * 10
                end
            end
        end
    end

    hengfu = Instance.new("Frame")
    hengfu.Name = "NFSafetyBanner"
    hengfu.AutomaticSize = Enum.AutomaticSize.Y
    hengfu.Size = UDim2.new(1, -24, 0, 0)
    hengfu.BackgroundColor3 = Color3.fromRGB(36, 22, 22)
    hengfu.BorderSizePixel = 0
    hengfu.LayoutOrder = 25
    hengfu.Visible = false
    hengfu.ZIndex = 11
    hengfu.Parent = DaobanXiangqing
    shezhiYuanjiao(hengfu, 5)
    tianjiaMiaobian(hengfu, Yanse.BrandRed, 1, 0.55)

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 8)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)
    pad.Parent = hengfu

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 3)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = hengfu

    local head = Instance.new("TextLabel")
    head.BackgroundTransparency = 1
    head.Size = UDim2.new(1, 0, 0, 14)
    head.Font = Ziti.Bold
    head.TextSize = 10
    head.TextColor3 = Yanse.BrandRed
    head.TextXAlignment = Enum.TextXAlignment.Left
    head.Text = "HEADS UP"
    head.LayoutOrder = 1
    head.ZIndex = 12
    head.Parent = hengfu

    hengfuZhengwen = Instance.new("TextLabel")
    hengfuZhengwen.BackgroundTransparency = 1
    hengfuZhengwen.AutomaticSize = Enum.AutomaticSize.Y
    hengfuZhengwen.Size = UDim2.new(1, 0, 0, 0)
    hengfuZhengwen.Font = Ziti.Book
    hengfuZhengwen.TextSize = 12
    hengfuZhengwen.TextColor3 = NF.Ink
    hengfuZhengwen.TextWrapped = true
    hengfuZhengwen.TextXAlignment = Enum.TextXAlignment.Left
    hengfuZhengwen.TextYAlignment = Enum.TextYAlignment.Top
    hengfuZhengwen.LayoutOrder = 2
    hengfuZhengwen.ZIndex = 12
    hengfuZhengwen.Parent = hengfu
end)

local function gengxinHengfu()
    if not (hengfu and hengfuZhengwen) then return end
    local sp = selectedPirated
    if type(sp) ~= "table" then hengfu.Visible = false return end

    local lines = {}
    if not (sp.verified == true or sp.Verified == true) then
        table.insert(lines, "Unverified script. Review what it does before running it.")
    end
    if sp.key == true or sp.Key == true then
        table.insert(lines, "Uses a key system. It may send you to external websites.")
    end
    if sp.isPatched == true or sp.Patched == true then
        table.insert(lines, "Marked as patched. It probably no longer works.")
    end

    hengfu.Visible = #lines > 0
    hengfuZhengwen.Text = table.concat(lines, "\n")
end

try("banner hooks", function()
    local biaotiBq = DaobanKuangjia:FindFirstChild("PiratedDetailTitle", true)
    if biaotiBq then
        biaotiBq:GetPropertyChangedSignal("Text"):Connect(function() task.defer(gengxinHengfu) end)
    end
    DaobanXiangqing:GetPropertyChangedSignal("Visible"):Connect(function()
        if DaobanXiangqing.Visible then task.defer(gengxinHengfu) end
    end)
end)

try("comments", function()
    local pinglunKuangjia = DaobanKuangjia:FindFirstChild("PiratedComments", true)
    if not pinglunKuangjia then return end

    local biaotou
    for _, c in ipairs(DaobanXiangqing:GetChildren()) do
        if c:IsA("TextLabel") and c.Text:find("^COMMUNITY COMMENTS") then biaotou = c end
    end

    local token = 0
    local function shuaxinShuliang()
        token = token + 1
        local mine = token
        task.delay(0.1, function()
            if mine ~= token or not biaotou then return end
            local n = 0
            for _, c in ipairs(pinglunKuangjia:GetChildren()) do
                if c:IsA("Frame") then n = n + 1 end
            end
            biaotou.Text = n > 0 and ("COMMUNITY COMMENTS · " .. n) or "COMMUNITY COMMENTS"
        end)
    end

    local function yangshiPinglun(box)
        if not box:IsA("Frame") or box:GetAttribute("NFStyled") then return end
        box:SetAttribute("NFStyled", true)
        task.defer(function()
            for _, c in ipairs(box:GetChildren()) do

                if c:IsA("TextLabel") and c.TextWrapped then
                    c.AutomaticSize = Enum.AutomaticSize.Y
                    c.Size = UDim2.new(1, -20, 0, 0)
                    c.TextSize = shiShouji2() and 12 or 11
                    c.TextColor3 = NF.Ink
                end
            end
            box.AutomaticSize = Enum.AutomaticSize.Y
            local pad = Instance.new("UIPadding")
            pad.PaddingBottom = UDim.new(0, 10)
            pad.Parent = box
        end)
    end

    for _, c in ipairs(pinglunKuangjia:GetChildren()) do yangshiPinglun(c) end
    pinglunKuangjia.ChildAdded:Connect(function(c) yangshiPinglun(c); shuaxinShuliang() end)
    pinglunKuangjia.ChildRemoved:Connect(shuaxinShuliang)
    shuaxinShuliang()
end)

try("favorite", function()
    local fav = DaobanKuangjia:FindFirstChild("PiratedFavoriteBtn", true)
    if not fav then return end

    local function isIn(t)
        return t:find("In My List", 1, true) or t:find("✔", 1, true) or t:find("✓", 1, true)
    end

    local function yangshiShoucang()
        local zaiLiebiao = isIn(fav.Text) ~= nil
        local want = wodeLiebiaoBiaoqian(zaiLiebiao)
        if fav.Text ~= want then fav.Text = want end
        tween(fav, 0.15, {
            BackgroundColor3 = zaiLiebiao and NF.White or Color3.fromRGB(35, 35, 35),
            TextColor3 = zaiLiebiao and NF.Black or NF.White,
        })
    end

    fav:GetPropertyChangedSignal("Text"):Connect(yangshiShoucang)
    yangshiShoucang()

    fav.MouseButton1Click:Connect(function()
        if not selectedPirated then return end
        task.defer(function()
            tishi(isIn(fav.Text) and "Added to My List" or "Removed from My List")
        end)
    end)

    local yuanZhuti = gengxinDongtaiZhutiYanse
    gengxinDongtaiZhutiYanse = function(c)
        yuanZhuti(c)
        pcall(yangshiShoucang)
    end
end)

try("execute", function()
    local exec = DaobanKuangjia:FindFirstChild("PiratedExecute", true)
    if not exec then return end

    local function yangshiZhixing()
        local t = exec.Text
        local col = Yanse.BrandRed
        if t == "Executed" then
            col = NF.Green
        elseif t == "Failed" or t == "No Source" then
            col = NF.Red
        end
        tween(exec, 0.15, {BackgroundColor3 = col})
    end
    exec:GetPropertyChangedSignal("Text"):Connect(yangshiZhixing)
end)

end

AnNetflixDaoban()

function AnNetflixRunse()

if not (ZhuKuangjia and PingmuJiemian and luyouDaoShitu and BofangBtn and ShoucangBtn and FanhuiBtn
        and FenleiBtn and FenleiXiala and KongZhuangtai and DaimaShuru and ZhixingDongzuoBtn) then
    warn("[AN Netflix polish] Paste this INTO the main script after ANNetflixPirated().")
    return
end

local NF = {
    White = Color3.fromRGB(255, 255, 255),
    Black = Color3.fromRGB(0, 0, 0),
    Ghost = Color3.fromRGB(109, 109, 110),
    Green = Color3.fromRGB(46, 125, 50),
    Red   = Color3.fromRGB(198, 40, 40),
}

local function try(label, fn)
    local ok, err = pcall(fn)
    if not ok then warn("[AN Netflix polish] " .. label .. ": " .. tostring(err)) end
end

local function tween(obj, t, props)
    DonghuaFuwu:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local function bianan(c, k)
    return Color3.new(c.R * k, c.G * k, c.B * k)
end

local function bangdingXuanting(btn, rest, xuanting)
    if not btn or btn:GetAttribute("ANPolishHover") then return end
    btn:SetAttribute("ANPolishHover", true)
    btn.MouseEnter:Connect(function() tween(btn, 0.12, {BackgroundColor3 = xuanting(rest())}) end)
    btn.MouseLeave:Connect(function() tween(btn, 0.12, {BackgroundColor3 = rest()}) end)
end

local function bangdingAnxia(btn)
    if not btn or btn:GetAttribute("ANPolishPress") then return end
    btn:SetAttribute("ANPolishPress", true)
    local sc = btn:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
    sc.Scale = 1
    sc.Parent = btn
    local function to(s) tween(sc, 0.08, {Scale = s}) end
    btn.MouseButton1Down:Connect(function() to(0.97) end)
    btn.MouseButton1Up:Connect(function() to(1) end)
    btn.MouseLeave:Connect(function() to(1) end)
end

local function shezhiYuanjiao(obj, r)
    local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = obj
end

try("detail reset", function()
    local function kuaizhaoXiangqingAnniu()
        BofangBtn.BackgroundColor3 = NF.White
        for _, b in ipairs({ShoucangBtn, FanhuiBtn}) do
            b.BackgroundColor3 = NF.Ghost
            b.BackgroundTransparency = 0.3
        end
        for _, b in ipairs({BofangBtn, ShoucangBtn, FanhuiBtn}) do
            local sc = b:FindFirstChildOfClass("UIScale")
            if sc then sc.Scale = 1 end
        end
    end

    local yuanLuyou = luyouDaoShitu
    luyouDaoShitu = function(viewName, ...)
        if viewName == "detail" then pcall(kuaizhaoXiangqingAnniu) end
        return yuanLuyou(viewName, ...)
    end
end)

try("detail press + list outline", function()
    for _, b in ipairs({BofangBtn, ShoucangBtn, FanhuiBtn}) do bangdingAnxia(b) end

    local miaobian = ShoucangBtn:FindFirstChildOfClass("UIStroke")
    local function tongbuShoucang()
        if miaobian then
            local zaiLiebiao = ShoucangBtn.Text == wodeLiebiaoBiaoqian(true)
            tween(miaobian, 0.15, {Color = zaiLiebiao and NF.White or Yanse.Border})
        end
    end
    ShoucangBtn:GetPropertyChangedSignal("Text"):Connect(tongbuShoucang)
    tongbuShoucang()
end)

local function zhixingJingzhi(btn)
    local t = btn.Text
    if t == "Executed" then return NF.Green end
    if t == "Failed" or t == "No Source" then return NF.Red end
    return Yanse.BrandRed
end

try("execute buttons", function()

    local zhixingAnniu = {ZhixingDongzuoBtn}
    local daobanZhixing = DaobanKuangjia and DaobanKuangjia:FindFirstChild("PiratedExecute", true)
    if daobanZhixing then table.insert(zhixingAnniu, daobanZhixing) end
    for _, b in ipairs(zhixingAnniu) do
        bangdingXuanting(b, function() return zhixingJingzhi(b) end, function(c) return bianan(c, 0.8) end)
        bangdingAnxia(b)
    end

    ZhixingDongzuoBtn:GetPropertyChangedSignal("Text"):Connect(function()
        tween(ZhixingDongzuoBtn, 0.15, {BackgroundColor3 = zhixingJingzhi(ZhixingDongzuoBtn)})
    end)

    local yuanZhuti = gengxinDongtaiZhutiYanse
    gengxinDongtaiZhutiYanse = function(c)
        yuanZhuti(c)
        for _, b in ipairs(zhixingAnniu) do
            pcall(function() b.BackgroundColor3 = zhixingJingzhi(b) end)
        end
    end

    if ZhixingQingkongBtn then
        local rest = Color3.fromRGB(35, 35, 35)
        bangdingXuanting(ZhixingQingkongBtn, function() return rest end, function() return Color3.fromRGB(55, 55, 55) end)
        bangdingAnxia(ZhixingQingkongBtn)
    end
end)

try("editor", function()
    DaimaShuru.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
    local miaobian = DaimaShuru:FindFirstChildOfClass("UIStroke")
    if not miaobian then return end
    miaobian.Color = NF.Ghost
    miaobian.Transparency = 0.6
    DaimaShuru.Focused:Connect(function()
        tween(miaobian, 0.15, {Color = NF.White, Transparency = 0})
    end)
    DaimaShuru.FocusLost:Connect(function()
        tween(miaobian, 0.15, {Color = NF.Ghost, Transparency = 0.6})
    end)
end)

try("genre dropdown", function()
    FenleiXiala.BackgroundColor3 = NF.Black
    local mianbanMiaobian = FenleiXiala:FindFirstChildOfClass("UIStroke")
    if mianbanMiaobian then
        mianbanMiaobian.Color = NF.Ghost
        mianbanMiaobian.Transparency = 0.5
    end

    local function sync()
        for _, row in ipairs(FenleiXiala:GetChildren()) do
            if row:IsA("TextButton") then
                local name = (row.Text:gsub("^%s+", ""))
                local bar = row:FindFirstChild("NFActiveBar")
                if not bar then
                    local pad = Instance.new("UIPadding")
                    pad.PaddingLeft = UDim.new(0, 8)
                    pad.Parent = row

                    bar = Instance.new("Frame")
                    bar.Name = "NFActiveBar"
                    bar.Size = UDim2.new(0, 3, 0, 14)
                    bar.AnchorPoint = Vector2.new(0, 0.5)
                    bar.Position = UDim2.new(0, -8, 0.5, 0)
                    bar.BackgroundColor3 = Yanse.BrandRed
                    bar.BorderSizePixel = 0
                    bar.ZIndex = row.ZIndex + 1
                    bar.Parent = row
                    shezhiYuanjiao(bar, 2)
                end
                bar.Visible = (name == DangqianFenlei)
            end
        end
    end

    sync()
    FenleiBtn:GetPropertyChangedSignal("Text"):Connect(sync)
    FenleiXiala:GetPropertyChangedSignal("Visible"):Connect(sync)
end)

try("empty state", function()
    local yuanGengxin = gengxinLunbo
    gengxinLunbo = function()
        if yuanGengxin then yuanGengxin() end
        KongZhuangtai.Text = (DangqianFenlei == "My List")
            and "Your list is empty. Open a title and tap \"+ My List\"."
            or "No matches found."
    end
end)

try("placeholder contrast", function()
    local function fix(d)
        if d:IsA("TextBox") then
            local c = d.PlaceholderColor3
            if (c.R + c.G + c.B) / 3 < 0.5 then
                d.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
    end
    for _, d in ipairs(PingmuJiemian:GetDescendants()) do fix(d) end
    PingmuJiemian.DescendantAdded:Connect(function(d) task.defer(fix, d) end)
end)

end

AnNetflixRunse()

-- 被封的人只能看到封禁界面
if shiYonghuYifeng then
    warn("AN Hub: Access Denied.\nTime Remaining: " .. fengjinShijianWenben)

    CaidanKuangjia:Destroy()
    BiaotouTiao:Destroy()
    local ZantingWenben = Instance.new("TextLabel")
    ZantingWenben.Size = UDim2.new(1, 0, 1, -60)
    ZantingWenben.BackgroundTransparency = 1
    ZantingWenben.Text = "ACCOUNT SUSPENDED"
    ZantingWenben.Font = Ziti.Heavy
    ZantingWenben.TextSize = 36
    ZantingWenben.TextColor3 = Yanse.BrandRed
    ZantingWenben.Parent = ZhuKuangjia

    local ZiWenben = Instance.new("TextLabel")
    ZiWenben.Size = UDim2.new(1, 0, 0, 40)
    ZiWenben.Position = UDim2.new(0, 0, 0.5, 30)
    ZiWenben.BackgroundTransparency = 1
    ZiWenben.Text = "Your access to AN Universal has been revoked.\nTime Remaining: " .. fengjinShijianWenben .. "\n\nClosing window in 3 seconds..."
    ZiWenben.Font = Ziti.Medium
    ZiWenben.TextSize = 14
    ZiWenben.TextColor3 = Yanse.GreyLight
    ZiWenben.Parent = ZhuKuangjia

    task.delay(3, function()
        local chuangkouDanchu = DonghuaFuwu:Create(ZhuKuangjia, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        })
        chuangkouDanchu:Play()
        chuangkouDanchu.Completed:Wait()
        if AN_HUANJING.AN_UNIVERSAL_GUI == PingmuJiemian then AN_HUANJING.AN_UNIVERSAL_GUI = nil end
        if AN_HUANJING.AN_UNIVERSAL_CLEANUP then AN_HUANJING.AN_UNIVERSAL_CLEANUP = nil end
        PingmuJiemian:Destroy()
    end)
else
    AN_HUANJING.AN_UNIVERSAL_GUI = PingmuJiemian
    jianchaZai()
    luyouDaoShitu("menu")
    gengxinXiangkaHang(DianyingXiangka)
    if gengxinLunbo then gengxinLunbo() end
end
engxinXiangkaHang(DianyingXiangka)
    if gengxinLunbo then gengxinLunbo() end
end
