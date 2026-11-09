-- Project Ai system - Model ai
-- Create NarsEdv

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local executorEnv = getfenv() :: any
local genv = (type(executorEnv.getgenv) == "function" and executorEnv.getgenv()) or _G

local function envGet(name)
    local value = executorEnv[name]
    if value == nil and type(genv) == "table" then
        value = genv[name]
    end
    return value
end

if type(genv.GeminiChatCleanup) == "function" then
    pcall(genv.GeminiChatCleanup)
end
genv.GeminiChatCleanup = nil

local player = Players.LocalPlayer
if not player then
    return
end

local CONFIG = {
    API_KEY = "",
    MODEL = "gemini-3.8-live",
    MODEL_LABEL = "Gemini 3.8 Live",
    ENDPOINT = "wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1beta.GenerativeService.BidiGenerateContent",
    SETUP_TIMEOUT = 15,
    RESPONSE_TIMEOUT = 45,
    DEBOUNCE_SAVE = 1.2,
    MAX_HISTORY = 40,
    MAX_RECORDS = 200,
    MAX_DISPLAY_CHARS = 15000,
    MAX_CODE_CHARS = 400000,
    MAX_CODE_LINE = 1500,
    LINES_PER_CHUNK = 40,
    CODE_MAX_HEIGHT = 280,
    CODE_COLLAPSED_HEIGHT = 76,
    MAX_INPUT_CHARS = 2000,
    DATA_FOLDER = "Project-Ai",
    HISTORY_FILE = "Project-Ai/history.json",
    LEGACY_HISTORY_FILE = "Chat Ai/Riwayat Chat.json",
    LEGACY_KEY_FILE = "Chat Ai/API Key.txt",
    GUI_TAG = "ChatAi_gui_tag",
    SYSTEM_PROMPT = "You are Gemini, a helpful assistant inside a chat panel. Be clear and concise. Always put source code inside fenced Markdown code blocks with a language tag.",
    UI = {
        PANEL_WIDTH = 480,
        PANEL_HEIGHT = 340,
        HEADER_HEIGHT = 32,
        SIDEBAR_WIDTH = 154,
        SIDEBAR_MARGIN = 8,
        SIDEBAR_LIST_TOP = 94,
        INPUT_MIN_HEIGHT = 32,
        INPUT_MAX_HEIGHT = 92,
        HEADER_ACTIONS_WIDTH = 84,
        MIN_WIDTH = 380,
        MIN_HEIGHT = 260,
        MAX_WIDTH = 820,
        MAX_HEIGHT = 680,
    }
}

local EMPTY_OBJECT = "__EMPTY_OBJECT__"

local PROFILES = {
    { mode = "realtime", audio = false },
    { mode = "legacy", audio = false },
    { mode = "realtime", audio = true },
    { mode = "legacy", audio = true },
}

local Icon = {
    Logo = "rbxassetid://122926744824622",
    Load = "rbxassetid://78408734580845",
    Menu = "rbxassetid://77021539815611",
    Close = "rbxassetid://75539660682193",
    Back = "rbxassetid://122268389930903",
    Search = "rbxassetid://92345384671606",
    Copy = "rbxassetid://78979572434545",
    ResizeCorner = "rbxassetid://103321376129527",
    Globe = "rbxassetid://114238209622913",
    Checklist = "rbxassetid://93898873302694",
    Send = "rbxassetid://127751956873796",
    Atom = "rbxassetid://73167696981648",
    Pen = "rbxassetid://109108135755303",
    Chat = "rbxassetid://92856823884663",
    Clear = "rbxassetid://133957773112410",
    Key = "rbxassetid://114238209622913",
    NewChat = "rbxassetid://106562979649273",
    More = "rbxassetid://117978708573781",
    Expand = "rbxassetid://136612013728069",
    Collapse = "rbxassetid://117796781690923",
    ArrowDown = "rbxassetid://136612013728069",
    Trash = "rbxassetid://133957773112410",
    arrowdown = "rbxassetid://98764963621439",
}

local COLORS = {
    bg = Color3.fromRGB(6, 6, 8),
    panel = Color3.fromRGB(12, 12, 14),
    panel2 = Color3.fromRGB(20, 20, 23),
    panel3 = Color3.fromRGB(30, 30, 35),
    border = Color3.fromRGB(44, 44, 50),
    text = Color3.fromRGB(240, 240, 244),
    sub = Color3.fromRGB(135, 135, 145),
    silver = Color3.fromRGB(205, 207, 215),
    silverDark = Color3.fromRGB(120, 122, 132),
    codeBg = Color3.fromRGB(8, 8, 10),
    codeText = Color3.fromRGB(200, 204, 212),
    alert = Color3.fromRGB(245, 90, 90),
    ink = Color3.fromRGB(12, 12, 14),
    white = Color3.new(1, 1, 1),
    accent = Color3.fromRGB(90, 140, 255),
    tableBg = Color3.fromRGB(16, 16, 20),
    tableHeader = Color3.fromRGB(25, 25, 32),
}

local STATE_KEYS = {
    disconnected = "stateDisconnected",
    connecting = "stateConnecting",
    connected = "stateConnected",
    error = "stateError",
}

local STATE_COLORS = {
    disconnected = Color3.fromRGB(235, 72, 72),
    connecting = Color3.fromRGB(205, 207, 215),
    connected = Color3.fromRGB(70, 214, 120),
    error = Color3.fromRGB(235, 72, 72),
}

local FONT_UI = Enum.Font.GothamMedium
local FONT_CODE = Enum.Font.Code

local SYNTAX = {
    keyword = "#C586C0",
    string = "#98C379",
    comment = "#5C6370",
    number = "#D19A66",
    constant = "#D19A66",
    func = "#61AFEF",
    builtin = "#E5C07B",
    member = "#E06C75",
    operator = "#56B6C2",
    type = "#E5C07B",
    muted = "#7A7E8A",
    inline = "#FFFFFF",
}

local function wordSet(source)
    local set = {}
    for word in source:gmatch("%S+") do
        set[word] = true
    end
    return set
end

local KEYWORDS = {
    lua = wordSet("and break continue do else elseif end for function if in local not or repeat return then until while export type"),
    py = wordSet("and as assert async await break class continue def del elif else except finally for from global if import in is lambda nonlocal not or pass raise return try while with yield"),
    c = wordSet("abstract async await break case catch class const continue debugger default delete do else enum export extends final finally for fn func function goto if impl implements import in instanceof interface let mut namespace new of override package private protected pub public return static struct super switch template this throw try typedef typeof union use using var virtual void volatile while with yield int long short char float double bool boolean byte string unsigned signed auto extern sizeof from as type"),
    sh = wordSet("if then else elif fi for while until do done case esac in function select return break continue local export readonly declare unset exit"),
}

local CONSTANTS = {
    lua = wordSet("true false nil"),
    py = wordSet("True False None"),
    c = wordSet("true false null nil undefined NaN Infinity True False None"),
    sh = wordSet("true false"),
}

local BUILTINS = {
    lua = wordSet("game workspace script shared Instance Vector3 Vector2 CFrame Color3 BrickColor UDim UDim2 Rect Enum TweenInfo Random Ray Region3 NumberRange NumberSequence ColorSequence Font OverlapParams RaycastParams task math string table os coroutine debug utf8 bit32 buffer print warn error pcall xpcall assert select type typeof tostring tonumber pairs ipairs next require getfenv setfenv setmetatable getmetatable rawget rawset rawequal rawlen unpack tick time wait spawn delay _G _VERSION Players RunService TweenService UserInputService HttpService ReplicatedStorage ServerStorage Lighting StarterGui CoreGui TextService Workspace"),
    py = wordSet("print len range int str float list dict set tuple bool open input type isinstance enumerate zip map filter sum min max abs sorted reversed super object Exception self cls"),
    c = wordSet("console Math JSON Object Array String Number Boolean Promise Map Set Date window document require module exports process Error RegExp Symbol System fmt"),
    sh = wordSet("echo cd ls cat grep sed awk curl wget source sudo apt git npm pip mkdir rm cp mv chmod"),
}

local FAMILIES = {
    [""] = "lua", lua = "lua", luau = "lua", roblox = "lua",
    python = "py", py = "py",
    sh = "sh", bash = "sh", shell = "sh", zsh = "sh",
    js = "c", javascript = "c", jsx = "c", ts = "c", typescript = "c", tsx = "c",
    java = "c", c = "c", cpp = "c", ["c++"] = "c", cs = "c", csharp = "c",
    go = "c", golang = "c", rust = "c", rs = "c", php = "c", kotlin = "c", kt = "c",
    swift = "c", dart = "c", scala = "c", json = "c", jsonc = "c",
}

local OPERATOR_CHARS = {}
for char in ("+-*/%^#=<>~&|!?"):gmatch(".") do
    OPERATOR_CHARS[char] = true
end

local L = {
    en = {
        newChat = "New Chat",
        chatExplorer = "Chat Explorer",
        searchPlaceholder = "Search chats...",
        connect = "Connect",
        disconnect = "Disconnect",
        cancel = "Cancel",
        cancelReply = "Cancel",
        close = "Close",
        stateDisconnected = "Disconnected",
        stateConnecting = "Connecting",
        stateConnected = "Connected",
        stateError = "Error",
        messagesCount = "%d messages",
        today = "Today",
        yesterday = "Yesterday",
        older = "Older",
        daysAgo = "%d days ago",
        placeholderOffline = "Connect to start chatting",
        placeholderReady = "Type your message here...",
        typing = "Gemini is typing...",
        connectedMsg = "Connected to Gemini successfully. You can start chatting now.",
        welcome = "Hi! I'm Gemini. Press Connect to start chatting. Replies support formatted text, tables, checklists, and collapsible code blocks.",
        copiedMessage = "Message copied",
        copiedCode = "Code copied",
        toastNoText = "No text to copy",
        toastClipboard = "Clipboard unavailable, copy manually",
        manualHint = "Manual copy: select all text, then copy",
        toastWait = "Wait for the response to finish",
        toastConnectFirst = "Connect first",
        toastSendFail = "Failed to send: %s",
        toastDeleted = "Chat deleted",
        toastCleared = "Chat cleared",
        toastEditing = "Editing message",
        toastLanguage = "Language: English",
        toastRenamed = "Chat renamed",
        confirmTitle = "Close Chat Ai?",
        confirmBody = "The panel will close and the connection will stop. Your chat history is saved.",
        errApi = "API error: %s",
        errInterrupted = "The response was stopped by the server.",
        errEmpty = "Empty response from Gemini. Try sending the message again.",
        errLostWaiting = "Connection lost while waiting for a response.",
        errClosedTurn = "The connection was closed.",
        errTimeout = "Timeout: Gemini did not respond within %d seconds.",
        renameChat = "Rename Chat",
        clearChat = "Clear Chat",
        switchLang = "Bahasa: Indonesia",
        deleteChat = "Delete Chat",
        expandCode = "Expand",
        collapseCode = "Collapse",
        scrollBottom = "Scroll to bottom",
        charsCount = "%d/%d",
    },
    id = {
        newChat = "Chat Baru",
        chatExplorer = "Penjelajah Chat",
        searchPlaceholder = "Cari chat...",
        connect = "Hubungkan",
        disconnect = "Putuskan",
        cancel = "Batal",
        cancelReply = "Batalkan",
        close = "Tutup",
        stateDisconnected = "Terputus",
        stateConnecting = "Menghubungkan",
        stateConnected = "Terhubung",
        stateError = "Error",
        messagesCount = "%d pesan",
        today = "Hari ini",
        yesterday = "Kemarin",
        older = "Lebih lama",
        daysAgo = "%d hari lalu",
        placeholderOffline = "Hubungkan untuk mulai chat",
        placeholderReady = "Ketik pesan Anda di sini...",
        typing = "Gemini sedang mengetik...",
        connectedMsg = "Berhasil terhubung ke Gemini. Silakan mulai chat.",
        welcome = "Halo! Saya Gemini. Tekan Hubungkan untuk mulai chat. Jawaban mendukung teks berformat, tabel, checklist, dan blok kode lipat.",
        copiedMessage = "Pesan disalin",
        copiedCode = "Kode disalin",
        toastNoText = "Tidak ada teks untuk disalin",
        toastClipboard = "Clipboard tidak tersedia, salin manual",
        manualHint = "Salin manual: pilih semua teks lalu salin",
        toastWait = "Tunggu respons selesai",
        toastConnectFirst = "Hubungkan terlebih dahulu",
        toastSendFail = "Gagal mengirim: %s",
        toastDeleted = "Chat dihapus",
        toastCleared = "Chat dibersihkan",
        toastEditing = "Mengedit pesan",
        toastLanguage = "Bahasa: Indonesia",
        toastRenamed = "Nama chat diperbarui",
        confirmTitle = "Tutup Chat Ai?",
        confirmBody = "Panel akan ditutup dan koneksi dihentikan. Riwayat chat Anda tersimpan.",
        errApi = "Error API: %s",
        errInterrupted = "Respons dihentikan oleh server.",
        errEmpty = "Respons kosong dari Gemini. Coba kirim ulang pesan.",
        errLostWaiting = "Koneksi terputus saat menunggu respons.",
        errClosedTurn = "Koneksi diputus.",
        errTimeout = "Timeout: Gemini tidak merespons dalam %d detik.",
        renameChat = "Ubah Nama",
        clearChat = "Bersihkan Chat",
        switchLang = "Language: English",
        deleteChat = "Hapus Chat",
        expandCode = "Perluas",
        collapseCode = "Ciutkan",
        scrollBottom = "Gulir ke bawah",
        charsCount = "%d/%d",
    },
}

local S: {[string]: any} = {
    alive = true,
    lang = "en",
    state = "disconnected",
    lastError = "",
    socket = nil,
    socketConnections = {},
    connections = {},
    pruneAt = 200,
    activeTweens = {},
    loopTweens = {},
    pulseTweens = {},
    pulseFor = nil,
    bound = {},
    sessionId = 0,
    turn = nil,
    generating = false,
    apiKey = "",
    goAway = false,
    userRequestedDisconnect = false,
    dirty = false,
    swapping = false,
    closeAfterTurn = false,
    sessionOk = false,
    historySent = false,
    stick = true,
    messageOrder = 0,
    toastToken = 0,
    enterGuard = false,
    sidebarOpen = true,
    panelOpen = true,
    panelToken = 0,
    avatarContent = nil,
    welcomeMsg = nil,
    userLimits = {},
    aiLimits = {},
    avatarLabels = {},
    conversations = {},
    activeConv = nil,
    convCounter = 0,
    spinTween = nil,
    dragging = false,
    resizing = false,
    dragStart = Vector3.new(0, 0, 0),
    startPosition = UDim2.new(0, 0, 0, 0),
    resizeStart = Vector2.new(0, 0),
    resizeOrigin = Vector2.new(0, 0),
    openDrag = nil,
    editId = nil,
    fileWarned = false,
    saveToken = 0,
    moreOpen = false,
    contextMenuConv = nil,
    contextTrigger = nil,
    profile = 3,
    announce = false,
    welcomeKey = "welcome",
    setupHistory = false,
    queue = {},
    lastDayStamp = nil,
    inputHeight = CONFIG.UI.INPUT_MIN_HEIGHT,
}

local function T(key, ...)
    local pack = L[S.lang] or L.en
    local text = pack[key] or L.en[key] or key
    if select("#", ...) > 0 then
        local ok, formatted = pcall(string.format, text, ...)
        if ok then
            return formatted
        end
    end
    return text
end

local function bind(inst, prop, key, ...)
    local entry = { inst = inst, prop = prop, key = key, args = table.pack(...) }
    S.bound[#S.bound + 1] = entry
    inst[prop] = T(key, table.unpack(entry.args, 1, entry.args.n))
    return entry
end

local function refreshBound()
    local kept = {}
    for _, entry in ipairs(S.bound) do
        if entry.inst.Parent then
            entry.inst[entry.prop] = T(entry.key, table.unpack(entry.args, 1, entry.args.n))
            kept[#kept + 1] = entry
        end
    end
    S.bound = kept
end

local connect
local restartSession
local switchConversation
local deleteConversation
local beginEdit
local cancelTurn
local dispatchMessage
local saveHistory
local saveHistoryDebounced
local closeMoreMenu
local toggleMoreMenu
local updateScrollBottomVisibility
local updateInputHeight
local drainQueue
local dropQueue

local function resolveHost(): Instance
    local getHiddenUi = executorEnv.gethui or executorEnv.get_hidden_gui
    if type(getHiddenUi) == "function" then
        local ok, hidden = pcall(getHiddenUi)
        if ok and typeof(hidden) == "Instance" then
            return hidden
        end
    end
    local ok, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)
    if ok and typeof(coreGui) == "Instance" then
        return coreGui
    end
    return player:WaitForChild("PlayerGui")
end

local function reportError(message)
    warn("[ChatAi] " .. tostring(message))
end

local host = resolveHost()
local GUI: {[string]: any} = {}

local function generateName()
    local bytes = {}
    for i = 1, 32 do
        bytes[i] = string.char(math.random(0, 255))
    end
    return "_NarsEdvChatAi_" .. table.concat(bytes)
end

local function trim(value)
    local s = tostring(value or "")
    s = s:gsub("^%s+", "")
    s = s:gsub("%s+$", "")
    return s
end

local function cutUtf8(s, limit)
    if #s <= limit then
        return s
    end
    local cut = limit
    while cut > 0 do
        local b = s:byte(cut + 1) or 0
        if b >= 128 and b < 192 then
            cut = cut - 1
        else
            break
        end
    end
    return s:sub(1, cut)
end

local function purgeOldGui()
    local containers = { host }
    local okCore, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)
    if okCore and typeof(coreGui) == "Instance" then
        table.insert(containers, coreGui)
    end
    local okPg, pg = pcall(function()
        return player:FindFirstChildOfClass("PlayerGui")
    end)
    if okPg and typeof(pg) == "Instance" then
        table.insert(containers, pg)
    end
    local tags = { CONFIG.GUI_TAG, "_narsedv_gui_tag" }
    local visited = {}
    for _, container in ipairs(containers) do
        if not visited[container] then
            visited[container] = true
            local okList, children = pcall(function()
                return container:GetChildren()
            end)
            if okList then
                for _, child in ipairs(children) do
                    for _, tag in ipairs(tags) do
                        local okAttr, tagged = pcall(function()
                            return child:GetAttribute(tag)
                        end)
                        if okAttr and tagged == true then
                            pcall(function()
                                child:Destroy()
                            end)
                            break
                        end
                    end
                end
            end
        end
    end
end

purgeOldGui()

local function readFileSafe(path)
    local isfileFn = envGet("isfile")
    local readfileFn = envGet("readfile")
    if type(isfileFn) ~= "function" or type(readfileFn) ~= "function" then
        return nil
    end
    local okExists, exists = pcall(isfileFn, path)
    if not okExists or not exists then
        return nil
    end
    local okRead, content = pcall(readfileFn, path)
    if okRead and type(content) == "string" then
        return content
    end
    return nil
end

local function writeFileSafe(path, content)
    local writefileFn = envGet("writefile")
    if type(writefileFn) ~= "function" then
        return false
    end
    local makefolderFn = envGet("makefolder")
    local isfolderFn = envGet("isfolder")
    if type(makefolderFn) == "function" then
        local exists = false
        if type(isfolderFn) == "function" then
            local okFolder, result = pcall(isfolderFn, CONFIG.DATA_FOLDER)
            exists = okFolder and result == true
        end
        if not exists then
            pcall(makefolderFn, CONFIG.DATA_FOLDER)
        end
    end
    local ok = pcall(writefileFn, path, content)
    return ok
end

local function purgeLegacyKey()
    local isfileFn = envGet("isfile")
    local delfileFn = envGet("delfile")
    if type(isfileFn) ~= "function" or type(delfileFn) ~= "function" then
        return
    end
    local okExists, exists = pcall(isfileFn, CONFIG.LEGACY_KEY_FILE)
    if okExists and exists then
        pcall(delfileFn, CONFIG.LEGACY_KEY_FILE)
    end
end

local function loadApiKey()
    purgeLegacyKey()
    return trim(CONFIG.API_KEY)
end

local function jsonString(value)
    local ok, encoded = pcall(function()
        return HttpService:JSONEncode({ value })
    end)
    if ok and type(encoded) == "string" then
        return encoded:sub(2, -2)
    end
    return '""'
end

local function serializeHistory()
    local list = {}
    for _, conv in ipairs(S.conversations) do
        if #conv.records > 0 then
            list[#list + 1] = conv
        end
    end
    local lines = {
        "{",
        '  "version": 1,',
        '  "language": ' .. jsonString(S.lang) .. ",",
        '  "counter": ' .. tostring(S.convCounter) .. ",",
        '  "conversations": [',
    }
    for index, conv in ipairs(list) do
        lines[#lines + 1] = "    {"
        lines[#lines + 1] = '      "id": ' .. tostring(conv.id) .. ","
        lines[#lines + 1] = '      "title": ' .. jsonString(conv.title) .. ","
        lines[#lines + 1] = '      "created": ' .. tostring(math.floor(conv.created)) .. ","
        lines[#lines + 1] = '      "updated": ' .. tostring(math.floor(conv.updated)) .. ","
        lines[#lines + 1] = '      "records": ['
        for recordIndex, record in ipairs(conv.records) do
            lines[#lines + 1] = "        {"
            lines[#lines + 1] = '          "id": ' .. jsonString(record.id or "") .. ","
            lines[#lines + 1] = '          "role": ' .. jsonString(record.role) .. ","
            lines[#lines + 1] = '          "time": ' .. tostring(math.floor(record.time)) .. ","
            lines[#lines + 1] = '          "text": ' .. jsonString(record.text)
            lines[#lines + 1] = "        }" .. (recordIndex < #conv.records and "," or "")
        end
        lines[#lines + 1] = "      ]"
        lines[#lines + 1] = "    }" .. (index < #list and "," or "")
    end
    lines[#lines + 1] = "  ]"
    lines[#lines + 1] = "}"
    return table.concat(lines, "\n")
end

function saveHistory()
    writeFileSafe(CONFIG.HISTORY_FILE, serializeHistory())
end

function saveHistoryDebounced()
    S.saveToken = S.saveToken + 1
    local currentToken = S.saveToken
    task.delay(CONFIG.DEBOUNCE_SAVE, function()
        if S.alive and S.saveToken == currentToken then
            saveHistory()
        end
    end)
end

local function deriveHistory(records)
    local history = {}
    for i = math.max(1, #records - CONFIG.MAX_HISTORY + 1), #records do
        history[#history + 1] = { role = records[i].role, parts = { { text = records[i].text } } }
    end
    while history[1] and history[1].role ~= "user" do
        table.remove(history, 1)
    end
    return history
end

local function loadHistory()
    local raw = readFileSafe(CONFIG.HISTORY_FILE) or readFileSafe(CONFIG.LEGACY_HISTORY_FILE)
    if not raw or trim(raw) == "" then
        return
    end
    local ok, data = pcall(function()
        return HttpService:JSONDecode(raw)
    end)
    if not ok or type(data) ~= "table" then
        return
    end
    if data.language == "en" or data.language == "id" then
        S.lang = data.language
    end
    local highest = 0
    if type(data.conversations) == "table" then
        for _, entry in ipairs(data.conversations) do
            if type(entry) == "table" and type(entry.records) == "table" then
                local records = {}
                for _, item in ipairs(entry.records) do
                    if type(item) == "table" and (item.role == "user" or item.role == "model") and type(item.text) == "string" then
                        records[#records + 1] = {
                            id = (type(item.id) == "string" and item.id ~= "" and item.id) or HttpService:GenerateGUID(false),
                            role = item.role,
                            text = item.text,
                            time = tonumber(item.time) or os.time(),
                        }
                    end
                end
                if #records > 0 then
                    local id = tonumber(entry.id) or (highest + 1)
                    highest = math.max(highest, id)
                    S.conversations[#S.conversations + 1] = {
                        id = id,
                        title = type(entry.title) == "string" and entry.title or "",
                        created = tonumber(entry.created) or os.time(),
                        updated = tonumber(entry.updated) or os.time(),
                        records = records,
                        history = deriveHistory(records),
                    }
                end
            end
        end
    end
    S.convCounter = math.max(tonumber(data.counter) or 0, highest, #S.conversations)
end

loadHistory()
if readFileSafe(CONFIG.HISTORY_FILE) == nil then
    saveHistory()
end

local function create(className, props, parent)
    local inst = Instance.new(className)
    local okName = pcall(function()
        inst.Name = generateName()
    end)
    if not okName then
        pcall(function()
            inst.Name = "ChatAi" .. HttpService:GenerateGUID(false)
        end)
    end
    if props then
        for key, value in pairs(props) do
            pcall(function()
                inst[key] = value
            end)
        end
    end
    if parent then
        inst.Parent = parent
    end
    return inst
end

local function frame(props, parent)
    local merged = { BorderSizePixel = 0 }
    for key, value in pairs(props) do
        merged[key] = value
    end
    return create("Frame", merged, parent)
end

local function label(props, parent)
    local merged = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = FONT_UI,
        TextColor3 = COLORS.text,
        TextSize = 10,
        Text = "",
    }
    for key, value in pairs(props) do
        merged[key] = value
    end
    return create("TextLabel", merged, parent)
end

local function button(props, parent)
    local merged = {
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Font = FONT_UI,
        TextColor3 = COLORS.text,
        TextSize = 10,
        Text = "",
    }
    for key, value in pairs(props) do
        merged[key] = value
    end
    return create("TextButton", merged, parent)
end

local function corner(parent, radius)
    return create("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function bubbleCorner(parent, radius, topLeft, topRight, bottomLeft, bottomRight)
    local uiCorner = create("UICorner", nil, parent)
    pcall(function()
        uiCorner.CornerRadius = UDim.new(0, radius)
        uiCorner.TopLeftRadius = UDim.new(0, topLeft)
        uiCorner.TopRightRadius = UDim.new(0, topRight)
        uiCorner.BottomLeftRadius = UDim.new(0, bottomLeft)
        uiCorner.BottomRightRadius = UDim.new(0, bottomRight)
    end)
    return uiCorner
end

local function stroke(parent, color, thickness, transparency)
    return create("UIStroke", {
        Color = color,
        Thickness = thickness,
        Transparency = transparency,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, parent)
end

local function padding(parent, top, bottom, left, right)
    return create("UIPadding", {
        PaddingTop = UDim.new(0, top),
        PaddingBottom = UDim.new(0, bottom),
        PaddingLeft = UDim.new(0, left),
        PaddingRight = UDim.new(0, right),
    }, parent)
end

local function listLayout(parent, gap, fillDirection)
    return create("UIListLayout", {
        Padding = UDim.new(0, gap),
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = fillDirection or Enum.FillDirection.Vertical,
    }, parent)
end

local function icon(parent, asset, size, color)
    return create("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, size, 0, size),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = asset,
        ImageColor3 = color or COLORS.text,
        ScaleType = Enum.ScaleType.Fit,
    }, parent)
end

local function addShadow(parent, blur, offsetY, transparency)
    local ok = pcall(function()
        local UIShadow = Instance.new("UIShadow")
        pcall(function()
            UIShadow.Name = "UIShadow"
        end)
        UIShadow.ZIndex = -1
        UIShadow.BlurRadius = UDim.new(0, blur)
        UIShadow.Color = Color3.fromRGB(0, 0, 0)
        UIShadow.Enabled = true
        UIShadow.Offset = UDim2.fromOffset(0, offsetY)
        UIShadow.Spread = UDim2.fromScale(0, 0)
        UIShadow.Transparency = transparency
        UIShadow.Parent = parent
    end)
    return ok
end

local function isPointer(input)
    return input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
end

local function track(connection)
    local list = S.connections
    list[#list + 1] = connection
    if #list >= S.pruneAt then
        local kept = {}
        for _, conn in ipairs(list) do
            if conn.Connected then
                kept[#kept + 1] = conn
            end
        end
        S.connections = kept
        S.pruneAt = #kept + 200
    end
    return connection
end

local function on(signal, handler)
    return track(signal:Connect(handler))
end

local function tween(inst, duration, goal, style, direction)
    local t = TweenService:Create(
        inst,
        TweenInfo.new(duration, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out),
        goal
    )
    S.activeTweens[t] = true
    local conn
    conn = t.Completed:Connect(function()
        S.activeTweens[t] = nil
        conn:Disconnect()
    end)
    t:Play()
    return t
end

local function loopTween(inst, info, goal)
    local t = TweenService:Create(inst, info, goal)
    S.loopTweens[t] = true
    t:Play()
    return t
end

local function cancelLoop(t)
    if t then
        S.loopTweens[t] = nil
        pcall(function()
            t:Cancel()
        end)
    end
end

local baseColors = setmetatable({}, { __mode = "k" })

local function setBase(btn, color)
    baseColors[btn] = color
    btn.BackgroundColor3 = color
end

local function styleButton(btn)
    btn.AutoButtonColor = false
    if not baseColors[btn] then
        baseColors[btn] = btn.BackgroundColor3
    end
    local scale = create("UIScale", { Scale = 1 }, btn)
    local hovered = false
    on(btn.MouseEnter, function()
        hovered = true
        if not btn.Active then
            return
        end
        tween(scale, 0.12, { Scale = 1.05 })
        if btn.BackgroundTransparency < 1 then
            tween(btn, 0.12, { BackgroundColor3 = baseColors[btn]:Lerp(COLORS.white, 0.14) })
        end
    end)
    on(btn.MouseLeave, function()
        hovered = false
        tween(scale, 0.12, { Scale = 1 })
        if btn.BackgroundTransparency < 1 then
            tween(btn, 0.12, { BackgroundColor3 = baseColors[btn] })
        end
    end)
    on(btn.MouseButton1Down, function()
        if btn.Active then
            tween(scale, 0.08, { Scale = 0.93 })
        end
    end)
    on(btn.MouseButton1Up, function()
        tween(scale, 0.1, { Scale = hovered and 1.05 or 1 })
    end)
end

local function iconButton(parent, asset, size, color, props)
    local merged = { BackgroundTransparency = 1 }
    for key, value in pairs(props) do
        merged[key] = value
    end
    local btn = button(merged, parent)
    local img = icon(btn, asset, size, color)
    styleButton(btn)
    return btn, img
end

local function limitText(s)
    if #s <= CONFIG.MAX_DISPLAY_CHARS then
        return s
    end
    return cutUtf8(s, CONFIG.MAX_DISPLAY_CHARS) .. "\n..."
end

local function esc(s)
    local r = s:gsub("&", "&amp;")
    r = r:gsub("<", "&lt;")
    r = r:gsub(">", "&gt;")
    return r
end

local function wrapColor(text, color)
    if color and text:find("%S") then
        return '<font color="' .. color .. '">' .. esc(text) .. "</font>"
    end
    return esc(text)
end

local function langFamily(lang)
    return FAMILIES[string.lower(lang or "")] or "plain"
end

local function highlightLine(line, state, family)
    local n = #line
    if n == 0 then
        return " ", state
    end
    local out = {}
    local count = 0
    local function emit(text, color)
        count = count + 1
        out[count] = color and wrapColor(text, color) or esc(text)
    end
    local keywords = KEYWORDS[family]
    local constants = CONSTANTS[family]
    local builtins = BUILTINS[family]
    local i = 1
    local prev = ""

    if state ~= "" then
        local kind, arg = state:match("^(%a+):(.*)$")
        local closer
        if kind == "lc" or kind == "ls" then
            closer = "]" .. string.rep("=", tonumber(arg) or 0) .. "]"
        elseif kind == "cc" then
            closer = "*/"
        else
            closer = arg
        end
        local color = (kind == "lc" or kind == "cc") and SYNTAX.comment or SYNTAX.string
        local _, stop = line:find(closer, 1, true)
        if stop then
            emit(line:sub(1, stop), color)
            i = stop + 1
            state = ""
        else
            emit(line, color)
            return table.concat(out), state
        end
    end

    while i <= n do
        local c = line:sub(i, i)
        local nx = line:sub(i + 1, i + 1)
        if c:find("^%s") then
            local _, stop = line:find("^%s+", i)
            emit(line:sub(i, stop))
            i = stop + 1
        elseif family == "lua" and c == "-" and nx == "-" then
            local level = line:match("^%-%-%[(=*)%[", i)
            if level then
                local _, stop = line:find("]" .. level .. "]", i + 4 + #level, true)
                if stop then
                    emit(line:sub(i, stop), SYNTAX.comment)
                    i = stop + 1
                    prev = ""
                else
                    emit(line:sub(i), SYNTAX.comment)
                    return table.concat(out), "lc:" .. #level
                end
            else
                emit(line:sub(i), SYNTAX.comment)
                i = n + 1
            end
        elseif family == "c" and c == "/" and nx == "/" then
            emit(line:sub(i), SYNTAX.comment)
            i = n + 1
        elseif family == "c" and c == "/" and nx == "*" then
            local _, stop = line:find("*/", i + 2, true)
            if stop then
                emit(line:sub(i, stop), SYNTAX.comment)
                i = stop + 1
                prev = ""
            else
                emit(line:sub(i), SYNTAX.comment)
                return table.concat(out), "cc:"
            end
        elseif (family == "py" or family == "sh") and c == "#" then
            emit(line:sub(i), SYNTAX.comment)
            i = n + 1
        elseif family == "c" and c == "#" and not line:sub(1, i - 1):find("%S") then
            local word = line:match("^#%s*%a*", i)
            emit(word, SYNTAX.keyword)
            i = i + #word
            prev = "x"
        elseif c == '"' or c == "'" or (c == "`" and family == "c") then
            if family == "py" and line:sub(i, i + 2) == string.rep(c, 3) then
                local delim = string.rep(c, 3)
                local _, stop = line:find(delim, i + 3, true)
                if stop then
                    emit(line:sub(i, stop), SYNTAX.string)
                    i = stop + 1
                else
                    emit(line:sub(i), SYNTAX.string)
                    return table.concat(out), "tq:" .. delim
                end
            else
                local j = i + 1
                while j <= n do
                    local d = line:sub(j, j)
                    if d == "\\" then
                        j = j + 2
                    elseif d == c then
                        break
                    else
                        j = j + 1
                    end
                end
                local stop = math.min(j, n)
                emit(line:sub(i, stop), SYNTAX.string)
                i = stop + 1
            end
            prev = "x"
        elseif family == "lua" and c == "[" and line:find("^%[=*%[", i) then
            local level = line:match("^%[(=*)%[", i)
            local _, stop = line:find("]" .. level .. "]", i + 2 + #level, true)
            if stop then
                emit(line:sub(i, stop), SYNTAX.string)
                i = stop + 1
                prev = "x"
            else
                emit(line:sub(i), SYNTAX.string)
                return table.concat(out), "ls:" .. #level
            end
        elseif c:find("^%d") then
            local num = line:match("^0[xX][%x_]+", i)
                or line:match("^0[bB][01_]+", i)
                or line:match("^%d[%d_]*%.?%d*[eE][%+%-]?%d+", i)
                or line:match("^%d[%d_]*%.?%d*", i)
            emit(num, SYNTAX.number)
            i = i + #num
            prev = "x"
        elseif c:find("^[%a_$]") then
            local word = line:match("^[%a_$][%w_$]*", i)
            local after = i + #word
            local isCall = line:find("^%s*%(", after) ~= nil
            local isMember = prev == "." or (prev == ":" and family == "lua")
            if isMember then
                emit(word, isCall and SYNTAX.func or SYNTAX.member)
            elseif keywords and keywords[word] then
                emit(word, SYNTAX.keyword)
            elseif constants and constants[word] then
                emit(word, SYNTAX.constant)
            elseif builtins and builtins[word] then
                emit(word, SYNTAX.builtin)
            elseif isCall and family ~= "plain" then
                emit(word, SYNTAX.func)
            elseif (family == "c" or family == "py") and word:find("^%u[%w_]*%l") then
                emit(word, SYNTAX.type)
            else
                emit(word)
            end
            i = after
            prev = "x"
        elseif OPERATOR_CHARS[c] and family ~= "plain" then
            local j = i
            while j <= n do
                local ch = line:sub(j, j)
                if not OPERATOR_CHARS[ch] then
                    break
                end
                if j > i then
                    local following = line:sub(j + 1, j + 1)
                    if family == "lua" and ch == "-" and following == "-" then
                        break
                    end
                    if family == "c" and ch == "/" and (following == "/" or following == "*") then
                        break
                    end
                end
                j = j + 1
            end
            emit(line:sub(i, j - 1), SYNTAX.operator)
            i = j
            prev = "o"
        else
            emit(c)
            i = i + 1
            prev = c
        end
    end
    return table.concat(out), state
end

local function tagsBalanced(s)
    local stack = {}
    for closing, name in s:gmatch("<(/?)(%a+)[^>]*>") do
        if closing == "" then
            stack[#stack + 1] = name
        else
            if stack[#stack] ~= name then
                return false
            end
            stack[#stack] = nil
        end
    end
    return #stack == 0
end

local function inlineFormat(raw)
    local spans = {}
    local masked = raw:gsub("`([^`\n]+)`", function(code)
        spans[#spans + 1] = code
        return "\1" .. #spans .. "\2"
    end)
    local e = esc(masked)
    e = e:gsub("%[([^%]]+)%]%(([^%)]+)%)", '<u>%1</u> <font color="' .. SYNTAX.muted .. '">(%2)</font>')
    e = e:gsub("%*%*%*(.-)%*%*%*", "<b><i>%1</i></b>")
    e = e:gsub("%*%*(.-)%*%*", "<b>%1</b>")
    e = e:gsub("%*([^%s%*][^%*]-)%*", "<i>%1</i>")
    e = e:gsub("~~(.-)~~", "<s>%1</s>")
    e = e:gsub("\1(%d+)\2", function(index)
        return '<b><font color="' .. SYNTAX.inline .. '">' .. esc(spans[tonumber(index)]) .. "</font></b>"
    end)
    return e
end

local function formatTableLine(line, isHeader)
    local cells = {}
    for cell in line:gmatch("|([^|\n]+)") do
        cells[#cells + 1] = trim(cell)
    end
    if #cells == 0 then
        return inlineFormat(line)
    end
    local formattedCells = {}
    for _, c in ipairs(cells) do
        local cellText = inlineFormat(c)
        if isHeader then
            cellText = "<b>" .. cellText .. "</b>"
        end
        formattedCells[#formattedCells + 1] = cellText
    end
    return '<font color="' .. (isHeader and SYNTAX.type or COLORS.silver) .. '">' .. table.concat(formattedCells, '  <font color="' .. SYNTAX.muted .. '">|</font>  ') .. "</font>"
end

local function formatInline(s)
    local lines = {}
    for line in (s .. "\n"):gmatch("(.-)\n") do
        local rendered
        local hashes, heading = line:match("^(#+)%s+(.*)$")
        local quote = line:match("^>%s?(.*)$")
        local checkUncheck, checkContent = line:match("^(%s*)[%*%-%+]%s+%[%s?%]%s+(.*)$")
        local checkDone, doneContent = line:match("^(%s*)[%*%-%+]%s+%[[xX]%]%s+(.*)$")
        local indent, bullet = line:match("^(%s*)[%*%-%+]%s+(.*)$")
        local numIndent, number, numbered = line:match("^(%s*)(%d+)[%.%)]%s+(.*)$")

        if line:match("^%s*%-%-%-+%s*$") or line:match("^%s*%*%*%*+%s*$") then
            rendered = '<font color="' .. SYNTAX.muted .. '">' .. string.rep("—", 24) .. "</font>"
        elseif line:match("^|%s*[:%-]+%s*|") then
            rendered = '<font color="' .. SYNTAX.muted .. '">' .. string.rep("┄", 24) .. "</font>"
        elseif line:match("^|.+|$") then
            rendered = formatTableLine(line, false)
        elseif heading then
            local lvl = #hashes
            local size = lvl == 1 and 15 or (lvl == 2 and 13 or (lvl == 3 and 12 or 11))
            rendered = '<font size="' .. size .. '"><b>' .. inlineFormat(heading) .. "</b></font>"
        elseif checkDone then
            rendered = string.rep("    ", math.floor(#checkDone / 2)) .. '<font color="' .. STATE_COLORS.connected .. '"><b>[✓]</b></font>  <s>' .. inlineFormat(doneContent) .. "</s>"
        elseif checkUncheck then
            rendered = string.rep("    ", math.floor(#checkUncheck / 2)) .. '<font color="' .. COLORS.sub .. '"><b>[  ]</b></font>  ' .. inlineFormat(checkContent)
        elseif quote then
            rendered = '<font color="' .. COLORS.accent .. '">▎</font> <i><font color="' .. COLORS.sub .. '">' .. inlineFormat(quote) .. "</font></i>"
        elseif bullet then
            rendered = string.rep("    ", math.floor(#indent / 2)) .. '<font color="' .. COLORS.accent .. '">•</font>  ' .. inlineFormat(bullet)
        elseif numbered then
            rendered = string.rep("    ", math.floor(#numIndent / 2)) .. '<font color="' .. COLORS.accent .. '">' .. number .. ".</font>  " .. inlineFormat(numbered)
        else
            rendered = inlineFormat(line)
        end
        if not tagsBalanced(rendered) then
            rendered = esc(line)
        end
        lines[#lines + 1] = rendered
    end
    return table.concat(lines, "\n")
end

local function pushText(segs, raw)
    local s = raw
    s = s:gsub("^\n+", "")
    s = s:gsub("%s+$", "")
    if s ~= "" then
        segs[#segs + 1] = { kind = "text", content = s }
    end
end

local function parseSegments(text)
    local segs = {}
    local source = text:gsub("\r", "")
    local len = #source
    local i = 1
    while i <= len do
        local fenceStart = string.find(source, "```", i, true)
        if not fenceStart then
            pushText(segs, source:sub(i))
            break
        end
        pushText(segs, source:sub(i, fenceStart - 1))
        local afterFence = fenceStart + 3
        local lineEnd = string.find(source, "\n", afterFence, true)
        local lang
        local bodyStart
        if lineEnd then
            lang = trim(source:sub(afterFence, lineEnd - 1))
            bodyStart = lineEnd + 1
        else
            lang = trim(source:sub(afterFence))
            bodyStart = len + 1
        end
        lang = lang:match("^%S+") or ""
        local fenceEnd = string.find(source, "```", bodyStart, true)
        if fenceEnd then
            local body = source:sub(bodyStart, fenceEnd - 1)
            body = body:gsub("\n$", "")
            segs[#segs + 1] = { kind = "code", lang = lang, content = body, closed = true }
            i = fenceEnd + 3
            if source:sub(i, i) == "\n" then
                i = i + 1
            end
        else
            local body = source:sub(bodyStart)
            body = body:gsub("`+$", "")
            segs[#segs + 1] = { kind = "code", lang = lang, content = body, closed = false }
            break
        end
    end
    return segs
end

local utcOffset = os.time(os.date("*t")) - os.time(os.date("!*t"))

local function dayNumber(t)
    return math.floor((t + utcOffset) / 86400)
end

local function dayGroup(t)
    local diff = dayNumber(os.time()) - dayNumber(t)
    if diff <= 0 then
        return "today"
    elseif diff == 1 then
        return "yesterday"
    else
        return "older"
    end
end

local function relativeLabel(t)
    local group = dayGroup(t)
    local base = T(group)
    if group == "older" then
        local diff = dayNumber(os.time()) - dayNumber(t)
        base = T("daysAgo", diff)
    end
    return base .. " • " .. os.date("%H:%M", t)
end

local function dateBadgeLabel(t)
    local group = dayGroup(t)
    if group == "today" then
        return T("today")
    elseif group == "yesterday" then
        return T("yesterday")
    else
        return os.date("%d %b %Y", t)
    end
end

GUI.screenGui = create("ScreenGui", {
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 50,
    IgnoreGuiInset = true,
}, nil)
GUI.screenGui:SetAttribute(CONFIG.GUI_TAG, true)

do
    local protectFns = {}
    local synTable = envGet("syn")
    if type(synTable) == "table" and type(synTable.protect_gui) == "function" then
        table.insert(protectFns, synTable.protect_gui)
    end
    for _, name in ipairs({ "protect_gui", "protectgui" }) do
        local fn = envGet(name)
        if type(fn) == "function" then
            table.insert(protectFns, fn)
        end
    end
    for _, fn in ipairs(protectFns) do
        if pcall(fn, GUI.screenGui) then
            break
        end
    end
end

GUI.screenGui.Parent = host

GUI.panel = frame({
    Position = UDim2.new(0.5, -CONFIG.UI.PANEL_WIDTH / 2, 0.5, -CONFIG.UI.PANEL_HEIGHT / 2),
    Size = UDim2.new(0, CONFIG.UI.PANEL_WIDTH, 0, CONFIG.UI.PANEL_HEIGHT),
    BackgroundColor3 = COLORS.bg,
    Active = true,
    ZIndex = 2,
}, GUI.screenGui)
corner(GUI.panel, 12)
S.startPosition = GUI.panel.Position

GUI.shadowFrame = nil
if not addShadow(GUI.panel, 14, 4, 0.5) then
    GUI.shadowFrame = frame({
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.55,
        ZIndex = 1,
    }, GUI.screenGui)
    corner(GUI.shadowFrame, 16)
    local function syncShadow()
        local sf = GUI.shadowFrame
        if not sf then
            return
        end
        local p = GUI.panel.Position
        local s = GUI.panel.Size
        sf.Position = UDim2.new(p.X.Scale, p.X.Offset - 6, p.Y.Scale, p.Y.Offset - 2)
        sf.Size = UDim2.new(0, s.X.Offset + 12, 0, s.Y.Offset + 12)
        sf.Visible = GUI.panel.Visible
    end
    syncShadow()
    on(GUI.panel:GetPropertyChangedSignal("Position"), syncShadow)
    on(GUI.panel:GetPropertyChangedSignal("Size"), syncShadow)
    on(GUI.panel:GetPropertyChangedSignal("Visible"), syncShadow)
end

GUI.main = create("CanvasGroup", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = COLORS.bg,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    GroupTransparency = 0,
}, GUI.panel)
corner(GUI.main, 12)

GUI.sidebar = frame({
    Size = UDim2.new(0, CONFIG.UI.SIDEBAR_WIDTH, 1, 0),
    BackgroundColor3 = COLORS.panel,
    ClipsDescendants = true,
}, GUI.main)

frame({
    Position = UDim2.new(1, -1, 0, 0),
    Size = UDim2.new(0, 1, 1, 0),
    BackgroundColor3 = COLORS.border,
    BackgroundTransparency = 0.4,
}, GUI.sidebar)

GUI.chatArea = frame({
    Position = UDim2.new(0, CONFIG.UI.SIDEBAR_WIDTH, 0, 0),
    Size = UDim2.new(1, -CONFIG.UI.SIDEBAR_WIDTH, 1, 0),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
}, GUI.main)

GUI.brandBar = frame({
    Size = UDim2.new(1, 0, 0, CONFIG.UI.HEADER_HEIGHT),
    BackgroundTransparency = 1,
    Active = true,
}, GUI.sidebar)

create("ImageLabel", {
    Position = UDim2.new(0, CONFIG.UI.SIDEBAR_MARGIN, 0, 5),
    Size = UDim2.new(0, 22, 0, 22),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Image = Icon.Logo,
    ScaleType = Enum.ScaleType.Fit,
}, GUI.brandBar)

label({
    Position = UDim2.new(0, 38, 0, 3),
    Size = UDim2.new(1, -42, 0, 14),
    Text = "Gemini Ai",
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
}, GUI.brandBar)

label({
    Position = UDim2.new(0, 38, 0, 16),
    Size = UDim2.new(1, -42, 0, 11),
    Text = "Create Nars Edv",
    TextSize = 8,
    TextColor3 = COLORS.sub,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
}, GUI.brandBar)

GUI.newChatBtn = button({
    Position = UDim2.new(0, CONFIG.UI.SIDEBAR_MARGIN, 0, 36),
    Size = UDim2.new(1, -CONFIG.UI.SIDEBAR_MARGIN * 2, 0, 24),
    BackgroundColor3 = COLORS.panel2,
}, GUI.sidebar)
corner(GUI.newChatBtn, 8)
create("ImageLabel", {
    Position = UDim2.new(0, 9, 0.5, -6),
    Size = UDim2.new(0, 12, 0, 12),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Image = Icon.NewChat,
    ImageColor3 = COLORS.silver,
    ScaleType = Enum.ScaleType.Fit,
}, GUI.newChatBtn)
GUI.newChatLabel = label({
    Position = UDim2.new(0, 28, 0, 0),
    Size = UDim2.new(1, -34, 1, 0),
    TextXAlignment = Enum.TextXAlignment.Left,
}, GUI.newChatBtn)
bind(GUI.newChatLabel, "Text", "newChat")
styleButton(GUI.newChatBtn)

GUI.explorerRow = frame({
    Position = UDim2.new(0, CONFIG.UI.SIDEBAR_MARGIN, 0, 68),
    Size = UDim2.new(1, -CONFIG.UI.SIDEBAR_MARGIN * 2, 0, 20),
    BackgroundTransparency = 1,
}, GUI.sidebar)

GUI.explorerLabel = label({
    Size = UDim2.new(1, -24, 1, 0),
    TextXAlignment = Enum.TextXAlignment.Left,
}, GUI.explorerRow)
padding(GUI.explorerLabel, 0, 0, 2, 0)
bind(GUI.explorerLabel, "Text", "chatExplorer")

GUI.searchBtn = iconButton(GUI.explorerRow, Icon.Search, 12, COLORS.silver, {
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    Size = UDim2.new(0, 20, 0, 20),
})

GUI.searchFrame = frame({
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, -24, 1, 0),
    BackgroundColor3 = COLORS.panel2,
    Visible = false,
}, GUI.explorerRow)
corner(GUI.searchFrame, 6)
stroke(GUI.searchFrame, COLORS.silver, 0.5, 0.5)

GUI.searchBox = create("TextBox", {
    Position = UDim2.new(0, 5, 0, 0),
    Size = UDim2.new(1, -10, 1, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    PlaceholderColor3 = COLORS.sub,
    Text = "",
    TextColor3 = COLORS.text,
    TextSize = 9,
    Font = FONT_UI,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClipsDescendants = true,
}, GUI.searchFrame)
bind(GUI.searchBox, "PlaceholderText", "searchPlaceholder")

GUI.chatList = create("ScrollingFrame", {
    Position = UDim2.new(0, CONFIG.UI.SIDEBAR_MARGIN, 0, CONFIG.UI.SIDEBAR_LIST_TOP),
    Size = UDim2.new(1, -CONFIG.UI.SIDEBAR_MARGIN * 2, 0, 100),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    ScrollBarImageColor3 = COLORS.border,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
}, GUI.sidebar)
listLayout(GUI.chatList, 2)

GUI.bottomBlock = frame({
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 0, 1, -CONFIG.UI.SIDEBAR_MARGIN),
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1,
}, GUI.sidebar)
listLayout(GUI.bottomBlock, 6)
padding(GUI.bottomBlock, 0, 0, CONFIG.UI.SIDEBAR_MARGIN, CONFIG.UI.SIDEBAR_MARGIN)

GUI.statusRow = frame({
    Size = UDim2.new(1, 0, 0, 14),
    BackgroundTransparency = 1,
    LayoutOrder = 1,
    Active = true,
}, GUI.bottomBlock)

GUI.statusHalo = frame({
    Position = UDim2.new(0, -2, 0.5, -6),
    Size = UDim2.new(0, 12, 0, 12),
    BackgroundColor3 = STATE_COLORS.disconnected,
    BackgroundTransparency = 0.8,
    Visible = false,
}, GUI.statusRow)
corner(GUI.statusHalo, 6)

GUI.statusDot = frame({
    Position = UDim2.new(0, 1, 0.5, -3),
    Size = UDim2.new(0, 6, 0, 6),
    BackgroundColor3 = STATE_COLORS.disconnected,
}, GUI.statusRow)
corner(GUI.statusDot, 3)

GUI.loadIcon = create("ImageLabel", {
    Position = UDim2.new(0, 0, 0.5, -5),
    Size = UDim2.new(0, 10, 0, 10),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Image = Icon.Load,
    ImageColor3 = COLORS.silver,
    Visible = false,
}, GUI.statusRow)

GUI.statusLabel = label({
    Position = UDim2.new(0, 14, 0, 0),
    Size = UDim2.new(0.5, -14, 1, 0),
    Text = T("stateDisconnected"),
    TextSize = 9,
    TextColor3 = COLORS.sub,
    TextXAlignment = Enum.TextXAlignment.Left,
}, GUI.statusRow)

label({
    Position = UDim2.new(0.5, 0, 0, 0),
    Size = UDim2.new(0.5, 0, 1, 0),
    Text = CONFIG.MODEL_LABEL,
    TextSize = 8,
    TextColor3 = COLORS.sub,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextTruncate = Enum.TextTruncate.AtEnd,
}, GUI.statusRow)

GUI.errorTooltip = frame({
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 4, 0, -4),
    Size = UDim2.new(0, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.XY,
    BackgroundColor3 = COLORS.panel2,
    Visible = false,
    ZIndex = 50,
}, GUI.statusRow)
corner(GUI.errorTooltip, 6)
stroke(GUI.errorTooltip, COLORS.alert, 1, 0.5)
padding(GUI.errorTooltip, 4, 4, 8, 8)
GUI.errorTooltipText = label({
    Size = UDim2.new(0, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.XY,
    TextSize = 8,
    TextColor3 = COLORS.alert,
    TextWrapped = true,
}, GUI.errorTooltip)

on(GUI.statusRow.MouseEnter, function()
    if S.lastError ~= "" and S.state == "error" then
        GUI.errorTooltipText.Text = S.lastError
        GUI.errorTooltip.Visible = true
    end
end)
on(GUI.statusRow.MouseLeave, function()
    GUI.errorTooltip.Visible = false
end)

GUI.connectBtn = button({
    Size = UDim2.new(1, 0, 0, 24),
    BackgroundColor3 = COLORS.white,
    LayoutOrder = 2,
}, GUI.bottomBlock)
corner(GUI.connectBtn, 8)
baseColors[GUI.connectBtn] = COLORS.white
GUI.connectIcon = create("ImageLabel", {
    Position = UDim2.new(0, 9, 0.5, -6),
    Size = UDim2.new(0, 12, 0, 12),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Image = Icon.Key,
    ImageColor3 = COLORS.ink,
    ScaleType = Enum.ScaleType.Fit,
}, GUI.connectBtn)
GUI.connectLabel = label({
    Position = UDim2.new(0, 28, 0, 0),
    Size = UDim2.new(1, -34, 1, 0),
    Text = T("connect"),
    TextColor3 = COLORS.ink,
    TextXAlignment = Enum.TextXAlignment.Left,
}, GUI.connectBtn)
styleButton(GUI.connectBtn)

GUI.header = frame({
    Size = UDim2.new(1, 0, 0, CONFIG.UI.HEADER_HEIGHT),
    BackgroundColor3 = COLORS.panel,
    Active = true,
}, GUI.chatArea)

frame({
    Position = UDim2.new(0, 0, 1, -1),
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = COLORS.border,
    BackgroundTransparency = 0.4,
}, GUI.header)

GUI.menuBtn = iconButton(GUI.header, Icon.Menu, 13, COLORS.text, {
    Position = UDim2.new(0, 6, 0.5, -10),
    Size = UDim2.new(0, 20, 0, 20),
})

local HEADER_TEXT_OFFSET = -(32 + CONFIG.UI.HEADER_ACTIONS_WIDTH + 8)

GUI.titleLabel = label({
    Position = UDim2.new(0, 32, 0, 3),
    Size = UDim2.new(1, HEADER_TEXT_OFFSET, 0, 14),
    Text = T("newChat"),
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
}, GUI.header)

GUI.titleBox = create("TextBox", {
    Position = UDim2.new(0, 32, 0, 3),
    Size = UDim2.new(1, HEADER_TEXT_OFFSET, 0, 14),
    BackgroundColor3 = COLORS.panel3,
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    Text = "",
    TextColor3 = COLORS.text,
    TextSize = 11,
    Font = FONT_UI,
    TextXAlignment = Enum.TextXAlignment.Left,
    Visible = false,
}, GUI.header)
corner(GUI.titleBox, 4)

GUI.headerSub = label({
    Position = UDim2.new(0, 32, 0, 17),
    Size = UDim2.new(1, HEADER_TEXT_OFFSET, 0, 11),
    Text = T("messagesCount", 0) .. " • " .. os.date("%H:%M"),
    TextSize = 8,
    TextColor3 = COLORS.sub,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
}, GUI.header)

GUI.headerActions = frame({
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -6, 0.5, 0),
    Size = UDim2.new(0, 0, 0, 20),
    AutomaticSize = Enum.AutomaticSize.X,
    BackgroundTransparency = 1,
}, GUI.header)
create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center,
}, GUI.headerActions)

GUI.moreBtn = iconButton(GUI.headerActions, Icon.More, 12, COLORS.silver, {
    Size = UDim2.new(0, 20, 0, 20),
    LayoutOrder = 1,
})

GUI.backBtn = iconButton(GUI.headerActions, Icon.Back, 11, COLORS.text, {
    Size = UDim2.new(0, 20, 0, 20),
    LayoutOrder = 2,
    BackgroundTransparency = 0,
    BackgroundColor3 = COLORS.panel,
})
corner(GUI.backBtn, 6)

GUI.closeBtn = iconButton(GUI.headerActions, Icon.Close, 11, COLORS.text, {
    Size = UDim2.new(0, 20, 0, 20),
    LayoutOrder = 3,
    BackgroundTransparency = 0,
    BackgroundColor3 = COLORS.panel,
})
corner(GUI.closeBtn, 6)

GUI.moreMenuCard = frame({
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -6, 0, CONFIG.UI.HEADER_HEIGHT + 3),
    Size = UDim2.new(0, 142, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundColor3 = COLORS.panel2,
    Visible = false,
    ZIndex = 40,
}, GUI.chatArea)
corner(GUI.moreMenuCard, 8)
stroke(GUI.moreMenuCard, COLORS.border, 1, 0.3)
padding(GUI.moreMenuCard, 4, 4, 4, 4)
listLayout(GUI.moreMenuCard, 2)
addShadow(GUI.moreMenuCard, 10, 4, 0.45)

local function createMenuItem(iconAsset, textKey, onClick)
    local item = button({
        Size = UDim2.new(1, 0, 0, 22),
        BackgroundColor3 = COLORS.panel3,
        BackgroundTransparency = 1,
    }, GUI.moreMenuCard)
    corner(item, 6)
    create("ImageLabel", {
        Position = UDim2.new(0, 6, 0.5, -6),
        Size = UDim2.new(0, 12, 0, 12),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = iconAsset,
        ImageColor3 = COLORS.silver,
        ScaleType = Enum.ScaleType.Fit,
    }, item)
    local itemLabel = label({
        Position = UDim2.new(0, 24, 0, 0),
        Size = UDim2.new(1, -28, 1, 0),
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, item)
    bind(itemLabel, "Text", textKey)
    item.MouseEnter:Connect(function()
        tween(item, 0.1, { BackgroundTransparency = 0 })
    end)
    item.MouseLeave:Connect(function()
        tween(item, 0.1, { BackgroundTransparency = 1 })
    end)
    item.MouseButton1Click:Connect(function()
        closeMoreMenu()
        onClick()
    end)
    return item
end

GUI.messages = create("ScrollingFrame", {
    Position = UDim2.new(0, 0, 0, CONFIG.UI.HEADER_HEIGHT),
    Size = UDim2.new(1, 0, 1, -(CONFIG.UI.HEADER_HEIGHT + CONFIG.UI.INPUT_MIN_HEIGHT)),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = COLORS.border,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ClipsDescendants = true,
}, GUI.chatArea)
padding(GUI.messages, 8, 8, 8, 8)
listLayout(GUI.messages, 8)

GUI.scrollBottomBtn = create("ImageButton", {
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -12, 1, -(CONFIG.UI.INPUT_MIN_HEIGHT + 8)),
    Size = UDim2.new(0, 24, 0, 24),
    BackgroundColor3 = COLORS.panel2,
    BorderSizePixel = 0,
    Image = Icon.arrowdown,
    ImageColor3 = COLORS.silver,
    ScaleType = Enum.ScaleType.Fit,
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 15,
}, GUI.chatArea)
corner(GUI.scrollBottomBtn, 12)
stroke(GUI.scrollBottomBtn, COLORS.border, 1, 0.5)
styleButton(GUI.scrollBottomBtn)

GUI.inputBar = frame({
    Position = UDim2.new(0, 0, 1, -CONFIG.UI.INPUT_MIN_HEIGHT),
    Size = UDim2.new(1, 0, 0, CONFIG.UI.INPUT_MIN_HEIGHT),
    BackgroundColor3 = COLORS.panel,
}, GUI.chatArea)

frame({
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = COLORS.border,
    BackgroundTransparency = 0.4,
}, GUI.inputBar)

GUI.inputFrame = frame({
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, 8, 0.5, 0),
    Size = UDim2.new(1, -48, 0, CONFIG.UI.INPUT_MIN_HEIGHT - 6),
    BackgroundColor3 = COLORS.panel2,
}, GUI.inputBar)
corner(GUI.inputFrame, 8)
GUI.inputStroke = stroke(GUI.inputFrame, COLORS.silver, 0.5, 0.65)

GUI.inputBox = create("TextBox", {
    Position = UDim2.new(0, 8, 0, 0),
    Size = UDim2.new(1, -54, 1, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    MultiLine = true,
    TextWrapped = true,
    PlaceholderText = T("placeholderOffline"),
    PlaceholderColor3 = COLORS.sub,
    Text = "",
    TextColor3 = COLORS.text,
    TextSize = 10,
    Font = FONT_UI,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    ClipsDescendants = true,
}, GUI.inputFrame)

GUI.charCountLabel = label({
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -6, 0.5, 0),
    Size = UDim2.new(0, 44, 0, 12),
    Text = "0",
    TextSize = 8,
    TextColor3 = COLORS.sub,
    TextXAlignment = Enum.TextXAlignment.Right,
}, GUI.inputFrame)

GUI.sendBtn = button({
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -8, 0.5, 0),
    Size = UDim2.new(0, 26, 0, 26),
    BackgroundColor3 = COLORS.panel3,
    Active = false,
}, GUI.inputBar)
corner(GUI.sendBtn, 8)
GUI.sendIcon = icon(GUI.sendBtn, Icon.Send, 13, COLORS.sub)
baseColors[GUI.sendBtn] = COLORS.panel3
styleButton(GUI.sendBtn)

GUI.toastFrame = frame({
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -(CONFIG.UI.INPUT_MIN_HEIGHT + 6)),
    Size = UDim2.new(0, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.XY,
    BackgroundColor3 = COLORS.panel3,
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 30,
}, GUI.chatArea)
corner(GUI.toastFrame, 8)
padding(GUI.toastFrame, 5, 5, 10, 10)
GUI.toastLabel = label({
    Size = UDim2.new(0, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.XY,
    TextTransparency = 1,
    TextSize = 9,
    ZIndex = 31,
}, GUI.toastFrame)

GUI.contextMenu = frame({
    Size = UDim2.new(0, 110, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundColor3 = COLORS.panel2,
    Visible = false,
    ZIndex = 45,
}, GUI.sidebar)
corner(GUI.contextMenu, 8)
stroke(GUI.contextMenu, COLORS.border, 1, 0.3)
padding(GUI.contextMenu, 4, 4, 4, 4)
listLayout(GUI.contextMenu, 2)
addShadow(GUI.contextMenu, 10, 4, 0.45)

local function createContextMenuItem(iconAsset, textKey, onClick)
    local item = button({
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundColor3 = COLORS.panel3,
        BackgroundTransparency = 1,
    }, GUI.contextMenu)
    corner(item, 6)
    create("ImageLabel", {
        Position = UDim2.new(0, 6, 0.5, -5),
        Size = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = iconAsset,
        ImageColor3 = COLORS.silver,
        ScaleType = Enum.ScaleType.Fit,
    }, item)
    local itemLabel = label({
        Position = UDim2.new(0, 22, 0, 0),
        Size = UDim2.new(1, -26, 1, 0),
        TextSize = 8,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, item)
    bind(itemLabel, "Text", textKey)
    item.MouseEnter:Connect(function()
        tween(item, 0.1, { BackgroundTransparency = 0 })
    end)
    item.MouseLeave:Connect(function()
        tween(item, 0.1, { BackgroundTransparency = 1 })
    end)
    item.MouseButton1Click:Connect(function()
        GUI.contextMenu.Visible = false
        onClick()
    end)
    return item
end

GUI.manualOverlay = frame({
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.35,
    Visible = false,
    Active = true,
    ZIndex = 50,
}, GUI.main)

GUI.manualBox = frame({
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(1, -24, 1, -24),
    BackgroundColor3 = COLORS.panel,
}, GUI.manualOverlay)
corner(GUI.manualBox, 12)

GUI.manualHint = label({
    Position = UDim2.new(0, 10, 0, 6),
    Size = UDim2.new(1, -90, 0, 20),
    TextColor3 = COLORS.sub,
    TextXAlignment = Enum.TextXAlignment.Left,
}, GUI.manualBox)
bind(GUI.manualHint, "Text", "manualHint")

GUI.manualClose = button({
    Position = UDim2.new(1, -66, 0, 6),
    Size = UDim2.new(0, 56, 0, 20),
    BackgroundColor3 = COLORS.panel3,
}, GUI.manualBox)
corner(GUI.manualClose, 7)
bind(GUI.manualClose, "Text", "close")
styleButton(GUI.manualClose)

GUI.manualText = create("TextBox", {
    Position = UDim2.new(0, 8, 0, 32),
    Size = UDim2.new(1, -16, 1, -40),
    BackgroundColor3 = COLORS.codeBg,
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    MultiLine = true,
    TextWrapped = true,
    Text = "",
    TextColor3 = COLORS.silver,
    TextSize = 11,
    Font = FONT_CODE,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ClipsDescendants = true,
}, GUI.manualBox)
corner(GUI.manualText, 8)
padding(GUI.manualText, 6, 6, 8, 8)

GUI.confirmOverlay = frame({
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.35,
    Visible = false,
    Active = true,
    ZIndex = 60,
}, GUI.main)

GUI.confirmCard = frame({
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 240, 0, 118),
    BackgroundColor3 = COLORS.panel,
}, GUI.confirmOverlay)
corner(GUI.confirmCard, 12)
if not addShadow(GUI.confirmCard, 18, 6, 0.3) then
    local fallback = frame({
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 4),
        Size = UDim2.new(0, 252, 0, 130),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.6,
        ZIndex = 0,
    }, GUI.confirmOverlay)
    corner(fallback, 16)
end

GUI.confirmTitle = label({
    Position = UDim2.new(0, 14, 0, 12),
    Size = UDim2.new(1, -28, 0, 16),
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
}, GUI.confirmCard)
bind(GUI.confirmTitle, "Text", "confirmTitle")

GUI.confirmBody = label({
    Position = UDim2.new(0, 14, 0, 32),
    Size = UDim2.new(1, -28, 0, 44),
    TextSize = 9,
    TextColor3 = COLORS.sub,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
}, GUI.confirmCard)
bind(GUI.confirmBody, "Text", "confirmBody")

GUI.confirmCancel = button({
    Position = UDim2.new(0, 14, 1, -34),
    Size = UDim2.new(0.5, -19, 0, 24),
    BackgroundColor3 = COLORS.panel3,
}, GUI.confirmCard)
corner(GUI.confirmCancel, 8)
bind(GUI.confirmCancel, "Text", "cancel")
styleButton(GUI.confirmCancel)

GUI.confirmClose = button({
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -14, 1, -34),
    Size = UDim2.new(0.5, -19, 0, 24),
    BackgroundColor3 = COLORS.white,
    TextColor3 = COLORS.ink,
}, GUI.confirmCard)
corner(GUI.confirmClose, 8)
bind(GUI.confirmClose, "Text", "close")
baseColors[GUI.confirmClose] = COLORS.white
styleButton(GUI.confirmClose)

GUI.resizeHandle = create("ImageButton", {
    Position = UDim2.new(1, -14, 1, -14),
    Size = UDim2.new(0, 12, 0, 12),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Image = Icon.ResizeCorner,
    ImageColor3 = COLORS.silverDark,
    Rotation = -35,
    AutoButtonColor = false,
    ZIndex = 20,
}, GUI.main)

GUI.openBtn = create("ImageButton", {
    Position = UDim2.new(0, 16, 0.5, -15),
    Size = UDim2.new(0, 30, 0, 30),
    BackgroundColor3 = COLORS.panel,
    BorderSizePixel = 0,
    Image = Icon.Logo,
    ScaleType = Enum.ScaleType.Fit,
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 3,
}, GUI.screenGui)
corner(GUI.openBtn, 8)
addShadow(GUI.openBtn, 10, 3, 0.45)

local function toast(text, isError)
    if not S.alive then
        return
    end
    S.toastToken = S.toastToken + 1
    local mine = S.toastToken
    local baseY = -(S.inputHeight + 6)
    GUI.toastLabel.Text = text
    GUI.toastLabel.TextColor3 = isError and COLORS.alert or COLORS.text
    GUI.toastFrame.Position = UDim2.new(0.5, 0, 1, baseY + 8)
    GUI.toastFrame.Visible = true
    tween(GUI.toastFrame, 0.18, { BackgroundTransparency = 0.05, Position = UDim2.new(0.5, 0, 1, baseY) })
    tween(GUI.toastLabel, 0.18, { TextTransparency = 0 })
    task.delay(1.9, function()
        if not S.alive or mine ~= S.toastToken then
            return
        end
        tween(GUI.toastFrame, 0.25, { BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 1, baseY - 8) })
        tween(GUI.toastLabel, 0.25, { TextTransparency = 1 })
        task.delay(0.3, function()
            if S.alive and mine == S.toastToken then
                GUI.toastFrame.Visible = false
            end
        end)
    end)
end

local function clipboardWrite(text)
    local writers = {}
    for _, name in ipairs({ "setclipboard", "toclipboard", "set_clipboard" }) do
        local fn = envGet(name)
        if type(fn) == "function" then
            table.insert(writers, fn)
        end
    end
    local clip = envGet("Clipboard")
    if type(clip) == "table" and type(clip.set) == "function" then
        table.insert(writers, function(value)
            clip.set(value)
        end)
    end
    for _, writer in ipairs(writers) do
        local ok = pcall(writer, text)
        if ok then
            return true
        end
    end
    return false
end

local function showManualCopy(text)
    GUI.manualText.Text = cutUtf8(text, 60000)
    GUI.manualOverlay.Visible = true
    task.defer(function()
        if not S.alive then
            return
        end
        pcall(function()
            GUI.manualText:CaptureFocus()
            GUI.manualText.SelectionStart = 1
            GUI.manualText.CursorPosition = #GUI.manualText.Text + 1
        end)
    end)
end

local function copyWithFeedback(text, successMessage)
    if trim(text) == "" then
        toast(T("toastNoText"), true)
        return false
    end
    if clipboardWrite(text) then
        toast(successMessage, false)
        return true
    end
    showManualCopy(text)
    toast(T("toastClipboard"), true)
    return false
end

local function copyButton(parent, props, iconSize, getText, successKey)
    local btn, img = iconButton(parent, Icon.Copy, iconSize, COLORS.silver, props)
    local token = 0
    on(btn.MouseButton1Click, function()
        local ok = copyWithFeedback(getText(), T(successKey))
        token = token + 1
        local mine = token
        img.Image = ok and Icon.Checklist or Icon.Copy
        task.delay(1.4, function()
            if S.alive and mine == token and img.Parent then
                img.Image = Icon.Copy
            end
        end)
    end)
    return btn
end

local function nextOrder()
    S.messageOrder = S.messageOrder + 1
    return S.messageOrder
end

local function bubbleMax()
    return math.max(120, GUI.messages.AbsoluteSize.X * 0.8)
end

local function updateBubbleLimits()
    local maxWidth = bubbleMax()
    local userLimits = S.userLimits
    for i = #userLimits, 1, -1 do
        local constraint = userLimits[i]
        if constraint.Parent then
            constraint.MaxSize = Vector2.new(math.max(80, maxWidth - 20), math.huge)
        else
            table.remove(userLimits, i)
        end
    end
    local aiLimits = S.aiLimits
    for i = #aiLimits, 1, -1 do
        local constraint = aiLimits[i]
        if constraint.Parent then
            constraint.MaxSize = Vector2.new(maxWidth, math.huge)
        else
            table.remove(aiLimits, i)
        end
    end
end

local function scrollToBottom()
    local y = math.max(0, GUI.messages.AbsoluteCanvasSize.Y - GUI.messages.AbsoluteWindowSize.Y)
    GUI.messages.CanvasPosition = Vector2.new(0, y)
    S.stick = true
    updateScrollBottomVisibility()
end

function updateScrollBottomVisibility()
    local remaining = GUI.messages.AbsoluteCanvasSize.Y - GUI.messages.AbsoluteWindowSize.Y - GUI.messages.CanvasPosition.Y
    local show = remaining > 48
    if GUI.scrollBottomBtn.Visible ~= show then
        GUI.scrollBottomBtn.Visible = show
        if show then
            GUI.scrollBottomBtn.ImageTransparency = 1
            GUI.scrollBottomBtn.BackgroundTransparency = 1
            tween(GUI.scrollBottomBtn, 0.15, { ImageTransparency = 0, BackgroundTransparency = 0 })
        end
    end
end

on(GUI.messages:GetPropertyChangedSignal("AbsoluteSize"), updateBubbleLimits)
on(GUI.messages:GetPropertyChangedSignal("AbsoluteCanvasSize"), function()
    if S.stick then
        scrollToBottom()
    else
        updateScrollBottomVisibility()
    end
end)
on(GUI.messages:GetPropertyChangedSignal("CanvasPosition"), function()
    local remaining = GUI.messages.AbsoluteCanvasSize.Y - GUI.messages.AbsoluteWindowSize.Y - GUI.messages.CanvasPosition.Y
    S.stick = remaining < 24
    updateScrollBottomVisibility()
end)

on(GUI.scrollBottomBtn.MouseButton1Click, scrollToBottom)

task.spawn(function()
    local ok, content = pcall(function()
        return Players:GetUserThumbnailAsync(
            player.UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size48x48
        )
    end)
    if S.alive and ok and type(content) == "string" then
        S.avatarContent = content
        local labels = S.avatarLabels
        for i = #labels, 1, -1 do
            local img = labels[i]
            if img.Parent then
                img.Image = content
            else
                table.remove(labels, i)
            end
        end
    end
end)

local function addDateSeparator(stamp)
    local day = dayNumber(stamp)
    if S.lastDayStamp == day then
        return
    end
    S.lastDayStamp = day

    local sep = frame({
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        LayoutOrder = nextOrder(),
    }, GUI.messages)

    local pill = frame({
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = COLORS.panel2,
    }, sep)
    corner(pill, 8)
    padding(pill, 0, 0, 8, 8)

    label({
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = dateBadgeLabel(stamp),
        TextSize = 8,
        TextColor3 = COLORS.sub,
    }, pill)
end

local function addUserMessage(text, stamp, animate, id)
    addDateSeparator(stamp)
    local wrapper = frame({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = nextOrder(),
    }, GUI.messages)

    local avatar = frame({
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundColor3 = COLORS.panel3,
    }, wrapper)
    corner(avatar, 12)
    local photo = create("ImageLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = S.avatarContent or "",
    }, avatar)
    corner(photo, 12)
    table.insert(S.avatarLabels, photo)

    local column = frame({
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -30, 0, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
    }, wrapper)
    create("UIListLayout", {
        Padding = UDim.new(0, 3),
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
    }, column)

    local bubble = frame({
        Size = UDim2.new(0, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = COLORS.panel3,
        LayoutOrder = 1,
    }, column)
    bubbleCorner(bubble, 8, 8, 8, 8, 0)
    padding(bubble, 7, 7, 10, 10)

    local textLabel = label({
        Size = UDim2.new(0, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        Text = limitText(text),
        TextSize = 10,
        TextWrapped = true,
        RichText = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
    }, bubble)
    local constraint = create("UISizeConstraint", {
        MaxSize = Vector2.new(math.max(80, bubbleMax() - 20), math.huge),
    }, textLabel)
    table.insert(S.userLimits, constraint)
    updateBubbleLimits()

    local timeRow = frame({
        Size = UDim2.new(0, 0, 0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
    }, column)
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }, timeRow)
    label({
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = os.date("%H:%M", stamp),
        TextSize = 8,
        TextColor3 = COLORS.sub,
        LayoutOrder = 1,
    }, timeRow)
    create("ImageLabel", {
        Size = UDim2.new(0, 11, 0, 11),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = Icon.Checklist,
        ImageColor3 = COLORS.sub,
        LayoutOrder = 2,
    }, timeRow)
    copyButton(timeRow, {
        Size = UDim2.new(0, 16, 0, 16),
        LayoutOrder = 3,
    }, 11, function()
        return text
    end, "copiedMessage")
    local editBtn = iconButton(timeRow, Icon.Pen, 11, COLORS.silver, {
        Size = UDim2.new(0, 16, 0, 16),
        LayoutOrder = 4,
    })
    on(editBtn.MouseButton1Click, function()
        if id then
            beginEdit(id)
        end
    end)

    if animate ~= false then
        bubble.BackgroundTransparency = 1
        textLabel.TextTransparency = 1
        column.Position = UDim2.new(1, -16, 0, 0)
        tween(column, 0.2, { Position = UDim2.new(1, -30, 0, 0) })
        tween(bubble, 0.2, { BackgroundTransparency = 0 })
        tween(textLabel, 0.2, { TextTransparency = 0 })
    end
    return wrapper
end

local function createTextSegment(parent, order)
    local textLabel = label({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextSize = 10,
        TextWrapped = true,
        RichText = true,
        TextColor3 = COLORS.silver,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        LayoutOrder = order,
    }, parent)
    return {
        kind = "text",
        frame = textLabel,
        update = function(_, seg)
            local shown = formatInline(limitText(seg.content))
            if textLabel.Text ~= shown then
                textLabel.Text = shown
            end
        end,
    }
end

local LANG_ALIAS = {
    js = "javascript",
    jsx = "javascript",
    node = "javascript",
    nodejs = "javascript",
    ts = "typescript",
    tsx = "typescript",
    py = "python",
    python3 = "python",
    sh = "bash",
    shell = "bash",
    zsh = "bash",
    console = "bash",
    luau = "lua",
    yml = "yaml",
    md = "markdown",
    htm = "html",
    ["c#"] = "csharp",
    cs = "csharp",
    ["c++"] = "cpp",
    rb = "ruby",
    rs = "rust",
    golang = "go",
    ps1 = "powershell",
    plaintext = "text",
    plain = "text",
    txt = "text",
}

local function displayLang(lang, content)
    local name = string.lower(tostring(lang or ""))
    name = (name:gsub("^language%-", ""))
    name = name:match("^[%w#%+%-_]+") or ""
    name = LANG_ALIAS[name] or name
    if name ~= "" then
        return name
    end
    local head = string.sub(tostring(content or ""), 1, 600)
    local upper = string.upper(head)
    if head:find("^%s*[%[{]") and head:find('"%s*:') then
        return "json"
    end
    if head:find("^#!") or head:find("^%s*sudo%s") or head:find("^%s*apt%s") or head:find("^%s*pip%s+install") then
        return "bash"
    end
    if upper:find("<!DOCTYPE", 1, true) or upper:find("<HTML", 1, true) or head:find("</?div[%s>]") then
        return "html"
    end
    if upper:find("^%s*SELECT%s") or upper:find("^%s*INSERT%s+INTO") or upper:find("^%s*CREATE%s+TABLE") then
        return "sql"
    end
    if head:find("%f[%w]local%s+[%w_]+%s*=") or (head:find("%f[%w]function%s*[%w_.:]*%(") and head:find("%f[%w]end%f[%W]")) then
        return "lua"
    end
    if head:find("^%s*def%s+[%w_]+%(") or head:find("^%s*import%s+[%w_.]+%s*\n") or head:find("^%s*from%s+[%w_.]+%s+import") then
        return "python"
    end
    if head:find("[%.#]?[%w%-_]+%s*{%s*[%w%-]+%s*:") then
        return "css"
    end
    if head:find("%f[%w]const%s+[%w_]+%s*=") or head:find("%f[%w]let%s+[%w_]+%s*=") or head:find("=>") or head:find("console%.log") then
        return "javascript"
    end
    return "text"
end

local function createCodeSegment(parent, order)
    local block = frame({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = COLORS.codeBg,
        ClipsDescendants = true,
        LayoutOrder = order,
    }, parent)
    corner(block, 8)
    listLayout(block, 0)

    local bar = frame({
        Size = UDim2.new(1, 0, 0, 24),
        BackgroundColor3 = COLORS.codeBg,
        LayoutOrder = 1,
        ClipsDescendants = true,
    }, block)
    corner(bar, 8)

    local squareBottom = frame({
        Position = UDim2.new(0, 0, 1, -4),
        Size = UDim2.new(1, 0, 0, 4),
        BackgroundColor3 = COLORS.codeBg,
    }, bar)

    local langLabel = label({
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -80, 1, 0),
        Text = "text",
        TextSize = 9,
        TextColor3 = COLORS.sub,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
    }, bar)

    frame({
        Position = UDim2.new(0, 0, 1, -1),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = COLORS.border,
        BackgroundTransparency = 0.55,
    }, bar)

    local barActions = frame({
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -6, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 18),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
    }, bar)
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }, barActions)

    local entry = {
        kind = "code",
        frame = block,
        content = "",
        family = nil,
        cache = {},
        rows = {},
        digits = 0,
        numWidth = 10,
        collapsed = false,
    }

    local toggleBtn, toggleImg = iconButton(barActions, Icon.Collapse, 11, COLORS.silver, {
        Size = UDim2.new(0, 16, 0, 16),
        LayoutOrder = 1,
    })

    copyButton(barActions, {
        Size = UDim2.new(0, 16, 0, 16),
        LayoutOrder = 2,
    }, 11, function()
        return entry.content
    end, "copiedCode")

    local scroll = create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = COLORS.border,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.XY,
        ScrollingDirection = Enum.ScrollingDirection.XY,
        ClipsDescendants = true,
        LayoutOrder = 2,
    }, block)
    padding(scroll, 6, 6, 6, 8)

    local holder = frame({
        Size = UDim2.new(0, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
    }, scroll)
    listLayout(holder, 0)

    local function refreshScrollSize()
        if entry.collapsed then
            scroll.Size = UDim2.new(1, 0, 0, CONFIG.CODE_COLLAPSED_HEIGHT)
        else
            scroll.Size = UDim2.new(1, 0, 0, math.clamp(holder.AbsoluteSize.Y + 16, 28, CONFIG.CODE_MAX_HEIGHT))
        end
    end

    on(holder:GetPropertyChangedSignal("AbsoluteSize"), refreshScrollSize)

    on(toggleBtn.MouseButton1Click, function()
        entry.collapsed = not entry.collapsed
        toggleImg.Image = entry.collapsed and Icon.Expand or Icon.Collapse
        refreshScrollSize()
    end)

    local function createRow(index)
        local row = frame({
            Size = UDim2.new(0, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            LayoutOrder = index,
        }, holder)
        create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }, row)
        local numLabel = label({
            Size = UDim2.new(0, entry.numWidth, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 10,
            Font = FONT_CODE,
            TextColor3 = COLORS.sub,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextYAlignment = Enum.TextYAlignment.Top,
            LayoutOrder = 1,
        }, row)
        local codeLabel = label({
            Size = UDim2.new(0, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 10,
            Font = FONT_CODE,
            TextColor3 = COLORS.codeText,
            TextWrapped = false,
            RichText = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            LayoutOrder = 2,
        }, row)
        return { row = row, num = numLabel, code = codeLabel, count = 0 }
    end

    entry.update = function(_, seg)
        entry.content = seg.content
        local shownLang = displayLang(seg.lang, seg.content)
        if langLabel.Text ~= shownLang then
            langLabel.Text = shownLang
        end

        local family = langFamily(seg.lang)
        if family ~= entry.family then
            entry.family = family
            entry.cache = {}
        end

        local source = seg.content
        if #source > CONFIG.MAX_CODE_CHARS then
            source = cutUtf8(source, CONFIG.MAX_CODE_CHARS) .. "\n..."
        end
        source = (source:gsub("\t", "    "))

        local lines = {}
        local total = 0
        for line in (source .. "\n"):gmatch("(.-)\n") do
            total = total + 1
            lines[total] = line
        end

        local digits = #tostring(total)
        local widthChanged = digits ~= entry.digits
        entry.digits = digits
        entry.numWidth = 6 * digits + 4

        local cache = entry.cache
        local rows = entry.rows
        local chunkCount = math.ceil(total / CONFIG.LINES_PER_CHUNK)
        local state = ""

        for k = 1, chunkCount do
            local row = rows[k]
            if not row then
                row = createRow(k)
                rows[k] = row
            end
            local first = (k - 1) * CONFIG.LINES_PER_CHUNK + 1
            local last = math.min(total, k * CONFIG.LINES_PER_CHUNK)
            local count = last - first + 1
            local dirty = row.count ~= count
            local parts = {}
            for index = first, last do
                local line = lines[index]
                local cached = cache[index]
                if not cached or cached.text ~= line or cached.state ~= state then
                    local shown = line
                    if #shown > CONFIG.MAX_CODE_LINE then
                        shown = cutUtf8(shown, CONFIG.MAX_CODE_LINE) .. "..."
                    end
                    local rich, nextState = highlightLine(shown, state, family)
                    cached = { text = line, state = state, rich = rich, out = nextState }
                    cache[index] = cached
                    dirty = true
                end
                parts[#parts + 1] = cached.rich
                state = cached.out
            end
            if dirty then
                row.code.Text = table.concat(parts, "\n")
                if row.count ~= count then
                    local numbers = {}
                    for index = first, last do
                        numbers[#numbers + 1] = tostring(index)
                    end
                    row.num.Text = table.concat(numbers, "\n")
                    row.count = count
                end
            end
            if widthChanged then
                row.num.Size = UDim2.new(0, entry.numWidth, 0, 0)
            end
        end

        for k = #rows, chunkCount + 1, -1 do
            rows[k].row:Destroy()
            rows[k] = nil
        end
        for index = #cache, total + 1, -1 do
            cache[index] = nil
        end
    end

    return entry
end

local function addAiMessage()
    local wrapper = frame({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = nextOrder(),
    }, GUI.messages)

    local avatar = frame({
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundColor3 = COLORS.panel3,
    }, wrapper)
    corner(avatar, 12)
    icon(avatar, Icon.Atom, 14, COLORS.silver)

    local bubble = frame({
        Position = UDim2.new(0, 30, 0, 0),
        Size = UDim2.new(1, -30, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = COLORS.panel2,
        Visible = false,
    }, wrapper)
    bubbleCorner(bubble, 8, 0, 8, 8, 8)
    padding(bubble, 8, 8, 10, 10)
    local constraint = create("UISizeConstraint", {
        MaxSize = Vector2.new(bubbleMax(), math.huge),
    }, bubble)
    table.insert(S.aiLimits, constraint)
    updateBubbleLimits()

    local content = frame({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, bubble)
    listLayout(content, 6)

    return {
        wrapper = wrapper,
        bubble = bubble,
        content = content,
        segments = {},
        text = "",
        copyRow = nil,
        cancelRow = nil,
        typing = nil,
        revealed = false,
        noCopy = false,
        generating = false,
    }
end

local function revealBubble(msg, animate)
    if msg.revealed then
        return
    end
    msg.revealed = true
    msg.bubble.Visible = true
    if animate ~= false then
        msg.bubble.BackgroundTransparency = 1
        msg.bubble.Position = UDim2.new(0, 18, 0, 0)
        tween(msg.bubble, 0.2, { BackgroundTransparency = 0, Position = UDim2.new(0, 30, 0, 0) })
    end
end

local function startTyping(msg)
    local holder = frame({
        Position = UDim2.new(0, 30, 0, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = COLORS.panel2,
    }, msg.wrapper)
    bubbleCorner(holder, 8, 0, 8, 8, 8)
    padding(holder, 9, 9, 12, 12)
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }, holder)

    local dots = frame({
        Size = UDim2.new(0, 34, 0, 14),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
    }, holder)
    local dotList = {}
    for i = 1, 3 do
        local dot = frame({
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0, 5 + (i - 1) * 12, 0.5, 0),
            Size = UDim2.new(0, 6, 0, 6),
            BackgroundColor3 = COLORS.silver,
            BackgroundTransparency = 0.7,
        }, dots)
        create("UICorner", { CornerRadius = UDim.new(1, 0) }, dot)
        dotList[i] = dot
    end

    local cancelBtn = button({
        Size = UDim2.new(0, 0, 0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = COLORS.panel3,
        TextSize = 9,
        LayoutOrder = 2,
    }, holder)
    corner(cancelBtn, 6)
    padding(cancelBtn, 0, 0, 8, 8)
    bind(cancelBtn, "Text", "cancelReply")
    styleButton(cancelBtn)
    on(cancelBtn.MouseButton1Click, function()
        cancelTurn()
    end)

    local started = os.clock()
    local conn = track(RunService.Heartbeat:Connect(function()
        local now = os.clock() - started
        for i, dot in ipairs(dotList) do
            local wave = (math.sin(now * 7 - (i - 1) * 0.9) + 1) / 2
            local size = 5 + wave * 2
            dot.Position = UDim2.new(0, 5 + (i - 1) * 12, 0.5, 3 - wave * 6)
            dot.Size = UDim2.new(0, size, 0, size)
            dot.BackgroundTransparency = 0.75 - wave * 0.7
        end
    end))

    msg.typing = { holder = holder, conn = conn, started = started }
end

local function stopTyping(msg)
    local typing = msg.typing
    if not typing then
        return
    end
    msg.typing = nil
    pcall(function()
        typing.conn:Disconnect()
    end)
    typing.holder:Destroy()
end

local function clearCancel(msg)
    if msg.cancelRow then
        msg.cancelRow:Destroy()
        msg.cancelRow = nil
    end
end

local function addCancelRow(msg)
    if msg.cancelRow then
        return
    end
    local row = frame({
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        LayoutOrder = 99999,
    }, msg.content)
    local btn = button({
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 18),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = COLORS.panel3,
        TextSize = 9,
    }, row)
    corner(btn, 6)
    padding(btn, 0, 0, 9, 9)
    bind(btn, "Text", "cancelReply")
    styleButton(btn)
    on(btn.MouseButton1Click, function()
        cancelTurn()
    end)
    msg.cancelRow = row
end

local MIN_TYPING_TIME = 0.8

local function renderAi(msg)
    if trim(msg.text) ~= "" then
        local typing = msg.typing
        if typing then
            local remain = MIN_TYPING_TIME - (os.clock() - typing.started)
            if remain > 0 then
                if not typing.waiting then
                    typing.waiting = true
                    task.delay(remain, function()
                        if S.alive and msg.typing == typing then
                            renderAi(msg)
                        end
                    end)
                end
                return
            end
        end
        stopTyping(msg)
        revealBubble(msg, true)
        if msg.generating then
            addCancelRow(msg)
        end
    end
    local segs = parseSegments(msg.text)
    local ui = msg.segments
    for i, seg in ipairs(segs) do
        local entry = ui[i]
        if entry and entry.kind ~= seg.kind then
            for j = #ui, i, -1 do
                ui[j].frame:Destroy()
                ui[j] = nil
            end
            entry = nil
        end
        if not entry then
            if seg.kind == "code" then
                entry = createCodeSegment(msg.content, i)
            else
                entry = createTextSegment(msg.content, i)
            end
            ui[i] = entry
        end
        entry:update(seg)
    end
    for j = #ui, #segs + 1, -1 do
        ui[j].frame:Destroy()
        ui[j] = nil
    end
end

local function finalizeAi(msg, stamp)
    renderAi(msg)
    clearCancel(msg)
    if msg.noCopy or msg.copyRow or trim(msg.text) == "" then
        return
    end
    local row = frame({
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        LayoutOrder = 100000,
    }, msg.content)
    label({
        Size = UDim2.new(0.5, 0, 1, 0),
        Text = os.date("%H:%M", stamp or os.time()),
        TextSize = 8,
        TextColor3 = COLORS.sub,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, row)
    copyButton(row, {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
    }, 11, function()
        return msg.text
    end, "copiedMessage")
    msg.copyRow = row
end

local function showAiError(msg, key, ...)
    stopTyping(msg)
    clearCancel(msg)
    for _, entry in ipairs(msg.segments) do
        entry.frame:Destroy()
    end
    msg.segments = {}
    msg.text = ""
    msg.noCopy = true
    revealBubble(msg, true)
    local errorLabel = label({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextColor3 = COLORS.alert,
        TextSize = 10,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        LayoutOrder = 1,
    }, msg.content)
    bind(errorLabel, "Text", key, ...)
end

local function addNotice(isError, key, ...)
    local noticeLabel = label({
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextColor3 = isError and COLORS.alert or COLORS.sub,
        TextSize = 9,
        TextWrapped = true,
        LayoutOrder = nextOrder(),
    }, GUI.messages)
    bind(noticeLabel, "Text", key, ...)
end

local function addWelcome()
    local msg = addAiMessage()
    msg.noCopy = true
    S.welcomeKey = "welcome"
    msg.text = T("welcome")
    renderAi(msg)
    S.welcomeMsg = msg
end

local function clearChat()
    for _, child in ipairs(GUI.messages:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end
    S.userLimits = {}
    S.aiLimits = {}
    S.welcomeMsg = nil
    S.stick = true
    S.lastDayStamp = nil
    updateScrollBottomVisibility()
end

local function displayTitle(conv)
    if conv.title ~= "" then
        return conv.title
    end
    return T("newChat")
end

local function newConversation()
    S.convCounter = S.convCounter + 1
    local now = os.time()
    local conv = {
        id = S.convCounter,
        title = "",
        created = now,
        updated = now,
        history = {},
        records = {},
    }
    table.insert(S.conversations, 1, conv)
    return conv
end

local function updateHeader()
    local conv = S.activeConv
    if not conv then
        return
    end
    GUI.titleLabel.Text = displayTitle(conv)
    GUI.headerSub.Text = T("messagesCount", #conv.records) .. " • " .. os.date("%H:%M", conv.updated)
end

local function renderConversation()
    clearChat()
    local conv = S.activeConv
    if #conv.records == 0 then
        addWelcome()
        return
    end
    for _, record in ipairs(conv.records) do
        if record.role == "user" then
            addUserMessage(record.text, record.time, false, record.id)
        else
            addDateSeparator(record.time)
            local msg = addAiMessage()
            msg.text = record.text
            revealBubble(msg, false)
            finalizeAi(msg, record.time)
        end
    end
end

local function showContextMenu(conv, trigger)
    if GUI.contextMenu.Visible and S.contextMenuConv == conv then
        GUI.contextMenu.Visible = false
        return
    end
    S.contextMenuConv = conv
    S.contextTrigger = trigger
    local margin = 6
    local sidebarPos = GUI.sidebar.AbsolutePosition
    local sidebarSize = GUI.sidebar.AbsoluteSize
    local menuWidth = GUI.contextMenu.Size.X.Offset
    local menuHeight = math.max(GUI.contextMenu.AbsoluteSize.Y, 50)
    local triggerPos = trigger.AbsolutePosition
    local triggerSize = trigger.AbsoluteSize
    local x = triggerPos.X + triggerSize.X - sidebarPos.X - menuWidth
    x = math.clamp(x, margin, math.max(margin, sidebarSize.X - menuWidth - margin))
    local y = triggerPos.Y + triggerSize.Y - sidebarPos.Y + 2
    if y + menuHeight > sidebarSize.Y - margin then
        y = triggerPos.Y - sidebarPos.Y - menuHeight - 2
    end
    y = math.clamp(y, margin, math.max(margin, sidebarSize.Y - menuHeight - margin))
    GUI.contextMenu.Position = UDim2.new(0, x, 0, y)
    GUI.contextMenu.Visible = true
end

local function rebuildList()
    for _, child in ipairs(GUI.chatList:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end
    local filter = string.lower(trim(GUI.searchBox.Text))

    local grouped = {
        today = {},
        yesterday = {},
        older = {},
    }

    for _, conv in ipairs(S.conversations) do
        local title = displayTitle(conv)
        if filter == "" or string.find(string.lower(title), filter, 1, true) then
            local grp = dayGroup(conv.updated)
            table.insert(grouped[grp], conv)
        end
    end

    local order = 0
    local sections = { "today", "yesterday", "older" }
    for _, grpKey in ipairs(sections) do
        local list = grouped[grpKey]
        if #list > 0 then
            order = order + 1
            local headerLabel = label({
                Size = UDim2.new(1, 0, 0, 16),
                Text = T(grpKey):upper(),
                TextSize = 8,
                TextColor3 = COLORS.silverDark,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = order,
            }, GUI.chatList)
            padding(headerLabel, 4, 0, 4, 0)

            for _, conv in ipairs(list) do
                order = order + 1
                local active = conv == S.activeConv
                local item = button({
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = COLORS.panel3,
                    BackgroundTransparency = active and 0 or 1,
                    LayoutOrder = order,
                }, GUI.chatList)
                corner(item, 6)

                create("ImageLabel", {
                    Position = UDim2.new(0, 6, 0.5, -6),
                    Size = UDim2.new(0, 12, 0, 12),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Image = Icon.Chat,
                    ImageColor3 = active and COLORS.accent or COLORS.silverDark,
                    ScaleType = Enum.ScaleType.Fit,
                }, item)

                label({
                    Position = UDim2.new(0, 24, 0, 3),
                    Size = UDim2.new(1, -44, 0, 12),
                    Text = displayTitle(conv),
                    TextSize = 9,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                }, item)
                label({
                    Position = UDim2.new(0, 24, 0, 15),
                    Size = UDim2.new(1, -44, 0, 10),
                    Text = os.date("%H:%M", conv.updated),
                    TextSize = 8,
                    TextColor3 = COLORS.sub,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                }, item)

                local moreItemBtn = button({
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -4, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    BackgroundTransparency = 1,
                }, item)
                icon(moreItemBtn, Icon.More, 9, COLORS.sub)

                item.MouseEnter:Connect(function()
                    if conv ~= S.activeConv then
                        tween(item, 0.1, { BackgroundTransparency = 0.6 })
                    end
                end)
                item.MouseLeave:Connect(function()
                    if conv ~= S.activeConv then
                        tween(item, 0.1, { BackgroundTransparency = 1 })
                    end
                end)
                item.MouseButton1Click:Connect(function()
                    switchConversation(conv)
                end)
                moreItemBtn.MouseButton1Click:Connect(function()
                    showContextMenu(conv, moreItemBtn)
                end)
            end
        end
    end
end

local function stopPulse()
    for _, t in ipairs(S.pulseTweens) do
        cancelLoop(t)
    end
    S.pulseTweens = {}
end

local function updateStatusRow()
    GUI.statusLabel.Text = T(STATE_KEYS[S.state] or "stateDisconnected")
    if S.pulseFor == S.state then
        return
    end
    S.pulseFor = S.state
    local color = STATE_COLORS[S.state] or STATE_COLORS.disconnected
    GUI.statusDot.BackgroundColor3 = color
    GUI.statusHalo.BackgroundColor3 = color
    stopPulse()
    if S.state == "connected" then
        GUI.statusDot.BackgroundTransparency = 0.1
        GUI.statusHalo.BackgroundTransparency = 0.75
        GUI.statusHalo.Visible = true
        local info = TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
        S.pulseTweens = {
            loopTween(GUI.statusDot, info, { BackgroundTransparency = 0.65 }),
            loopTween(GUI.statusHalo, info, { BackgroundTransparency = 0.95 }),
        }
    else
        GUI.statusDot.BackgroundTransparency = 0
        GUI.statusHalo.Visible = false
    end
end

local function setSpinning(enabled)
    if enabled then
        if S.spinTween then
            return
        end
        GUI.loadIcon.Rotation = 0
        GUI.loadIcon.Visible = true
        GUI.statusDot.Visible = false
        S.spinTween = loopTween(
            GUI.loadIcon,
            TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
            { Rotation = 360 }
        )
    else
        cancelLoop(S.spinTween)
        S.spinTween = nil
        GUI.loadIcon.Visible = false
        GUI.statusDot.Visible = true
    end
end

local function refreshControls()
    local canSend = S.state == "connected"
    GUI.inputBox.TextEditable = true
    if S.state == "connected" then
        GUI.inputBox.PlaceholderText = T("placeholderReady")
    else
        GUI.inputBox.PlaceholderText = T("placeholderOffline")
    end
    GUI.sendBtn.Active = canSend
    setBase(GUI.sendBtn, canSend and COLORS.white or COLORS.panel3)
    GUI.sendIcon.ImageColor3 = canSend and COLORS.ink or COLORS.sub
    updateStatusRow()
end

local function styleConnectButton()
    local primary = S.state == "disconnected" or S.state == "error"
    if S.state == "connected" then
        GUI.connectLabel.Text = T("disconnect")
    elseif S.state == "connecting" then
        GUI.connectLabel.Text = T("cancel")
    else
        GUI.connectLabel.Text = T("connect")
    end
    setBase(GUI.connectBtn, primary and COLORS.white or COLORS.panel3)
    GUI.connectLabel.TextColor3 = primary and COLORS.ink or COLORS.text
    GUI.connectIcon.ImageColor3 = primary and COLORS.ink or COLORS.text
end

local function setState(newState, detail)
    S.state = newState
    if detail then
        S.lastError = tostring(detail)
        if newState == "error" then
            reportError(detail)
        end
    elseif newState == "connected" then
        S.lastError = ""
    end
    styleConnectButton()
    setSpinning(newState == "connecting")
    refreshControls()
end

local function closeSocket()
    local current = S.socket
    S.socket = nil
    for _, conn in ipairs(S.socketConnections) do
        pcall(function()
            conn:Disconnect()
        end)
    end
    S.socketConnections = {}
    if current then
        pcall(function()
            current:Close()
        end)
    end
end

local function sendRaw(json)
    local current = S.socket
    if not current then
        return false, "Socket unavailable"
    end
    local ok, err = pcall(function()
        current:Send(json)
    end)
    if not ok then
        return false, tostring(err)
    end
    return true
end

local function sendJson(payload)
    local ok, json = pcall(function()
        return HttpService:JSONEncode(payload)
    end)
    if not ok then
        return false, "JSON error"
    end
    return sendRaw(json)
end

local function buildSetupJson()
    local languageName = S.lang == "id" and "Indonesian" or "English"
    local instruction = CONFIG.SYSTEM_PROMPT
        .. " The interface language is "
        .. languageName
        .. ". Always reply in "
        .. languageName
        .. " unless the user explicitly asks for another language."
    local payload = {
        setup = {
            model = "models/" .. CONFIG.MODEL,
            generationConfig = { responseModalities = { PROFILES[S.profile].audio and "AUDIO" or "TEXT" } },
            systemInstruction = { parts = { { text = instruction } } },
            contextWindowCompression = { slidingWindow = EMPTY_OBJECT },
        },
    }
    if PROFILES[S.profile].audio then
        payload.setup.outputAudioTranscription = EMPTY_OBJECT
    end
    S.setupHistory = false
    if PROFILES[S.profile].mode == "realtime" and S.activeConv and #S.activeConv.history > 0 then
        payload.setup.historyConfig = { initialHistoryInClientContent = true }
        S.setupHistory = true
    end
    local ok, json = pcall(function()
        return HttpService:JSONEncode(payload)
    end)
    if not ok then
        return nil
    end
    local replaced = json:gsub('"' .. EMPTY_OBJECT .. '"', "{}")
    return replaced
end

function dropQueue()
    local items = S.queue
    S.queue = {}
    if #items == 0 then
        return
    end
    local texts = {}
    for _, item in ipairs(items) do
        if item.wrapper and item.wrapper.Parent then
            item.wrapper:Destroy()
        end
        texts[#texts + 1] = item.text
    end
    if S.alive and GUI.inputBox.Text == "" then
        GUI.inputBox.Text = table.concat(texts, "\n")
    end
end

local function startSwap()
    S.swapping = true
    connect(true)
    if S.state ~= "connected" then
        S.swapping = false
    end
end

function drainQueue()
    if not S.alive or S.generating or S.swapping or S.state ~= "connected" then
        return
    end
    if S.dirty then
        if #S.queue > 0 then
            startSwap()
        end
        return
    end
    local item = table.remove(S.queue, 1)
    if not item then
        return
    end
    if not dispatchMessage(item.text, item) then
        if item.wrapper and item.wrapper.Parent then
            item.wrapper:Destroy()
        end
        if GUI.inputBox.Text == "" then
            GUI.inputBox.Text = item.text
        end
    end
end

local function endTurn(status, key, ...)
    local t = S.turn
    if not t then
        return
    end
    if status == "complete" and t.msg.typing and not t.noDelay and not t.finishing then
        local remain = MIN_TYPING_TIME - (os.clock() - t.msg.typing.started)
        if remain > 0 then
            t.finishing = true
            local args = table.pack(status, key, ...)
            task.delay(remain, function()
                if S.alive and S.turn == t then
                    endTurn(table.unpack(args, 1, args.n))
                end
            end)
            return
        end
    end
    S.turn = nil
    S.generating = false
    t.msg.generating = false
    stopTyping(t.msg)
    clearCancel(t.msg)
    if status == "complete" then
        local final = t.msg.text
        if trim(final) == "" then
            final = t.fallback
            t.msg.text = final
        end
        if trim(final) == "" then
            showAiError(t.msg, "errEmpty")
        else
            local conv = t.conv
            local now = os.time()
            table.insert(conv.history, { role = "user", parts = { { text = t.userText } } })
            table.insert(conv.history, { role = "model", parts = { { text = final } } })
            while #conv.history > CONFIG.MAX_HISTORY do
                table.remove(conv.history, 1)
            end
            while conv.history[1] and conv.history[1].role ~= "user" do
                table.remove(conv.history, 1)
            end
            table.insert(conv.records, { id = t.userId, role = "user", text = t.userText, time = t.userTime })
            table.insert(conv.records, { id = HttpService:GenerateGUID(false), role = "model", text = final, time = now })
            while #conv.records > CONFIG.MAX_RECORDS do
                table.remove(conv.records, 1)
            end
            conv.updated = now
            S.sessionOk = true
            finalizeAi(t.msg, now)
            updateHeader()
            rebuildList()
            saveHistoryDebounced()
        end
    else
        if trim(t.msg.text) ~= "" then
            finalizeAi(t.msg)
            addNotice(true, key, ...)
        else
            showAiError(t.msg, key, ...)
        end
    end
    refreshControls()
    if S.closeAfterTurn then
        S.closeAfterTurn = false
        restartSession()
    else
        task.defer(drainQueue)
    end
end

local function failConnection(sid, message)
    S.swapping = false
    if sid ~= S.sessionId or not S.alive then
        return
    end
    S.sessionId = S.sessionId + 1
    closeSocket()
    if S.turn then
        endTurn("failed", "errClosedTurn")
    end
    dropQueue()
    setState("error", message)
end

local function announceConnected()
    local welcome = S.welcomeMsg
    if welcome and welcome.wrapper.Parent then
        S.welcomeKey = "connectedMsg"
        welcome.text = T("connectedMsg")
        renderAi(welcome)
        return
    end
    local msg = addAiMessage()
    msg.noCopy = true
    msg.text = T("connectedMsg")
    renderAi(msg)
end

local function onSetupComplete(sid)
    if sid ~= S.sessionId or (S.state ~= "connecting" and not S.swapping) or S.historySent then
        return
    end
    S.historySent = true
    local history = S.activeConv.history
    if #history > 0 then
        local turns = {}
        for _, item in ipairs(history) do
            table.insert(turns, { role = item.role, parts = { { text = item.parts[1].text } } })
        end
        local ok, err = sendJson({ clientContent = { turns = turns, turnComplete = false } })
        if not ok then
            failConnection(sid, "Failed to restore history: " .. tostring(err))
            return
        end
    end
    S.swapping = false
    S.dirty = false
    setState("connected")
    if S.announce then
        S.announce = false
        announceConnected()
    end
    drainQueue()
end

local function queueRender(t)
    if t.renderQueued then
        return
    end
    t.renderQueued = true
    task.defer(function()
        t.renderQueued = false
        if S.alive and t.msg.wrapper.Parent and t.msg.bubble.Parent then
            renderAi(t.msg)
        end
    end)
end

local function handleServerContent(sc)
    local t = S.turn
    if not t then
        return
    end
    t.lastActivity = os.clock()

    local modelTurn = sc.modelTurn
    if type(modelTurn) == "table" and type(modelTurn.parts) == "table" then
        for _, part in ipairs(modelTurn.parts) do
            if not PROFILES[S.profile].audio and type(part) == "table" and type(part.text) == "string" and part.thought ~= true then
                t.msg.text = t.msg.text .. part.text
                t.fallback = t.fallback .. part.text
                queueRender(t)
            end
        end
    end

    local transcription = sc.outputTranscription
    if type(transcription) == "table" and type(transcription.text) == "string" and transcription.text ~= "" then
        if PROFILES[S.profile].audio or not modelTurn then
            t.msg.text = t.msg.text .. transcription.text
            t.fallback = t.fallback .. transcription.text
            queueRender(t)
        end
    end

    if sc.interrupted == true then
        endTurn("failed", "errInterrupted")
        return
    end

    if sc.turnComplete == true then
        endTurn("complete")
    end
end

local function onMessage(sid, raw)
    if sid ~= S.sessionId or not S.alive then
        return
    end
    if type(raw) ~= "string" then
        return
    end
    local ok, data = pcall(function()
        return HttpService:JSONDecode(raw)
    end)
    if not ok or type(data) ~= "table" then
        return
    end

    if S.turn then
        S.turn.lastActivity = os.clock()
    end

    if data.error ~= nil then
        local detail
        if type(data.error) == "table" then
            detail = tostring(data.error.message or data.error.status or "unknown error")
        else
            detail = tostring(data.error)
        end
        if S.state == "connecting" or S.swapping then
            failConnection(sid, "Setup failed: " .. detail)
        elseif S.turn then
            endTurn("failed", "errApi", detail)
        else
            setState("error", detail)
        end
        return
    end

    if data.setupComplete ~= nil then
        onSetupComplete(sid)
        return
    end

    if data.goAway ~= nil then
        S.goAway = true
        if S.turn then
            S.closeAfterTurn = true
        else
            restartSession()
            return
        end
    end

    if type(data.serverContent) == "table" then
        handleServerContent(data.serverContent)
    end
end

local function onSocketClosed(sid)
    if sid ~= S.sessionId or not S.alive or S.userRequestedDisconnect then
        return
    end
    local previous = S.state
    local plannedByServer = S.goAway
    local wasSwapping = S.swapping
    S.sessionId = S.sessionId + 1
    closeSocket()
    S.goAway = false
    S.closeAfterTurn = false
    S.swapping = false
    if previous == "connecting" or wasSwapping then
        if S.setupHistory and PROFILES[S.profile].mode == "realtime" then
            S.profile = S.profile + 1
        end
        dropQueue()
        setState("error", "Connection closed during setup. Check API key, model availability, or network, then press Connect.")
        return
    end
    setState("disconnected", (not plannedByServer) and "Connection closed unexpectedly." or nil)
    local t = S.turn
    if t then
        if not S.sessionOk and trim(t.msg.text) == "" and trim(t.fallback) == "" then
            S.profile = S.profile % #PROFILES + 1
        end
        endTurn("failed", "errLostWaiting")
    end
    dropQueue()
end

function connect(silent)
    if S.state == "connecting" or (S.state == "connected" and not silent) then
        return
    end
    local key = S.apiKey
    if key == "" then
        setState("error", "API key is empty. Set API_KEY in the CONFIG table.")
        return
    end
    local ws = envGet("WebSocket")
    if (type(ws) ~= "table" and type(ws) ~= "userdata") or type(ws.connect) ~= "function" then
        setState("error", "This executor does not support WebSocket.connect (sUNC).")
        return
    end

    S.userRequestedDisconnect = false
    S.closeAfterTurn = false
    S.historySent = false
    S.sessionOk = false
    closeSocket()
    S.sessionId = S.sessionId + 1
    local sid = S.sessionId
    S.goAway = false
    if not silent then
        S.dirty = false
        setState("connecting")
    end

    local setupJson = buildSetupJson()
    if not setupJson then
        failConnection(sid, "Failed to prepare setup configuration.")
        return
    end

    local url = CONFIG.ENDPOINT .. "?key=" .. HttpService:UrlEncode(key)

    task.spawn(function()
        local ok, result = pcall(function()
            return ws.connect(url)
        end)
        if not S.alive or sid ~= S.sessionId then
            if ok and result then
                pcall(function()
                    result:Close()
                end)
            end
            return
        end
        if not ok or not result then
            failConnection(sid, "Failed to open WebSocket connection.")
            return
        end

        S.socket = result

        local okMessage, messageConn = pcall(function()
            return result.OnMessage:Connect(function(message)
                onMessage(sid, message)
            end)
        end)
        local okClose, closeConn = pcall(function()
            return result.OnClose:Connect(function()
                onSocketClosed(sid)
            end)
        end)
        if okMessage then
            table.insert(S.socketConnections, messageConn)
        end
        if okClose then
            table.insert(S.socketConnections, closeConn)
        end
        if not okMessage or not okClose then
            failConnection(sid, "Failed to attach WebSocket events.")
            return
        end

        local sent, err = sendRaw(setupJson)
        if not sent then
            failConnection(sid, "Failed to send setup: " .. tostring(err))
            return
        end

        task.delay(CONFIG.SETUP_TIMEOUT, function()
            if S.alive and sid == S.sessionId and (S.state == "connecting" or S.swapping) then
                failConnection(sid, "Setup did not finish within " .. CONFIG.SETUP_TIMEOUT .. " seconds.")
            end
        end)
    end)
end

local function disconnect()
    S.swapping = false
    S.userRequestedDisconnect = true
    S.closeAfterTurn = false
    S.sessionId = S.sessionId + 1
    closeSocket()
    setState("disconnected")
    if S.turn then
        endTurn("failed", "errClosedTurn")
    end
    dropQueue()
end

function restartSession()
    S.swapping = false
    S.sessionId = S.sessionId + 1
    S.closeAfterTurn = false
    closeSocket()
    setState("disconnected")
    dropQueue()
end

local function markDirty()
    if S.state == "connected" then
        S.dirty = true
    end
end

local function startTurn(userText, prebuilt)
    local conv = S.activeConv
    if S.welcomeMsg then
        S.welcomeMsg.wrapper:Destroy()
        S.welcomeMsg = nil
    end
    if conv.title == "" and #conv.records == 0 then
        local single = trim((userText:gsub("%s+", " ")))
        if #single > 26 then
            single = cutUtf8(single, 26) .. "..."
        end
        conv.title = single
        rebuildList()
        updateHeader()
    end
    local stamp = prebuilt and prebuilt.stamp or os.time()
    local userId = prebuilt and prebuilt.id or HttpService:GenerateGUID(false)
    local userWrapper = prebuilt and prebuilt.wrapper or addUserMessage(userText, stamp, true, userId)
    local msg = addAiMessage()
    msg.generating = true
    startTyping(msg)
    local t = {
        msg = msg,
        conv = conv,
        userText = userText,
        userTime = stamp,
        userId = userId,
        userWrapper = userWrapper,
        fallback = "",
        lastActivity = os.clock(),
        renderQueued = false,
    }
    S.turn = t
    S.generating = true
    S.stick = true
    refreshControls()
    task.spawn(function()
        while S.alive and S.turn == t do
            task.wait(1)
            if S.alive and S.turn == t and os.clock() - t.lastActivity > CONFIG.RESPONSE_TIMEOUT then
                endTurn("failed", "errTimeout", CONFIG.RESPONSE_TIMEOUT)
                restartSession()
                return
            end
        end
    end)
end

function dispatchMessage(text, prebuilt)
    local ok, err
    if PROFILES[S.profile].mode == "legacy" then
        ok, err = sendJson({
            clientContent = {
                turns = { { role = "user", parts = { { text = text } } } },
                turnComplete = true,
            },
        })
    else
        ok, err = sendJson({ realtimeInput = { text = text } })
    end
    if not ok then
        reportError("Failed to send message: " .. tostring(err))
        toast(T("toastSendFail", tostring(err)), true)
        return false
    end
    startTurn(text, prebuilt)
    return true
end

function cancelTurn()
    local t = S.turn
    if not t then
        return
    end
    t.noDelay = true
    if trim(t.msg.text) ~= "" then
        endTurn("complete")
    else
        S.turn = nil
        S.generating = false
        t.msg.generating = false
        stopTyping(t.msg)
        clearCancel(t.msg)
        if t.msg.wrapper.Parent then
            t.msg.wrapper:Destroy()
        end
        if t.userWrapper and t.userWrapper.Parent then
            t.userWrapper:Destroy()
        end
        GUI.inputBox.Text = t.userText
        refreshControls()
    end
    S.dirty = true
end

local function applyEdit()
    local conv = S.activeConv
    local id = S.editId
    S.editId = nil
    if not id then
        return
    end
    local index
    for i, record in ipairs(conv.records) do
        if record.id == id then
            index = i
            break
        end
    end
    if not index then
        return
    end
    local removed = #conv.records - index + 1
    for _ = 1, removed do
        table.remove(conv.records)
    end
    for _ = 1, math.min(removed, #conv.history) do
        table.remove(conv.history)
    end
    while conv.history[1] and conv.history[1].role ~= "user" do
        table.remove(conv.history, 1)
    end
    if #conv.records == 0 then
        conv.title = ""
    end
    conv.updated = os.time()
    saveHistoryDebounced()
    renderConversation()
    updateHeader()
    rebuildList()
end

function beginEdit(id)
    if S.generating or S.swapping then
        toast(T("toastWait"), true)
        return
    end
    for _, record in ipairs(S.activeConv.records) do
        if record.role == "user" and record.id == id then
            S.editId = id
            GUI.inputBox.Text = record.text
            GUI.inputBox:CaptureFocus()
            toast(T("toastEditing"), false)
            updateInputHeight()
            return
        end
    end
end

function updateInputHeight()
    local text = GUI.inputBox.Text
    local charCount = #text
    GUI.charCountLabel.Text = tostring(charCount)
    if charCount > CONFIG.MAX_INPUT_CHARS then
        GUI.charCountLabel.TextColor3 = COLORS.alert
    else
        GUI.charCountLabel.TextColor3 = COLORS.sub
    end

    local lines = 1
    for _ in text:gmatch("\n") do
        lines = lines + 1
    end
    local targetHeight = math.clamp(CONFIG.UI.INPUT_MIN_HEIGHT + (lines - 1) * 14, CONFIG.UI.INPUT_MIN_HEIGHT, CONFIG.UI.INPUT_MAX_HEIGHT)
    if S.inputHeight ~= targetHeight then
        S.inputHeight = targetHeight
        tween(GUI.inputBar, 0.15, {
            Size = UDim2.new(1, 0, 0, targetHeight),
            Position = UDim2.new(0, 0, 1, -targetHeight),
        })
        tween(GUI.inputFrame, 0.15, {
            Size = UDim2.new(1, -48, 0, targetHeight - 6),
        })
        tween(GUI.messages, 0.15, {
            Size = UDim2.new(1, 0, 1, -(CONFIG.UI.HEADER_HEIGHT + targetHeight)),
        })
        tween(GUI.scrollBottomBtn, 0.15, {
            Position = UDim2.new(1, -12, 1, -(targetHeight + 8)),
        })
    end
end

local function sendMessage()
    local text = trim(GUI.inputBox.Text)
    if S.state ~= "connected" then
        toast(T("toastConnectFirst"), true)
        return
    end
    if text == "" then
        return
    end
    local function enqueue()
        local stamp = os.time()
        local id = HttpService:GenerateGUID(false)
        GUI.inputBox.Text = ""
        updateInputHeight()
        local wrapper = addUserMessage(text, stamp, true, id)
        table.insert(S.queue, { text = text, stamp = stamp, id = id, wrapper = wrapper })
    end
    if S.generating or S.swapping then
        enqueue()
        return
    end
    if S.editId then
        applyEdit()
        S.dirty = true
    end
    if S.dirty then
        enqueue()
        startSwap()
        return
    end
    if dispatchMessage(text) then
        GUI.inputBox.Text = ""
        updateInputHeight()
    end
end

local function startNewChat()
    if S.generating or S.swapping then
        toast(T("toastWait"), true)
        return
    end
    S.editId = nil
    S.activeConv = newConversation()
    renderConversation()
    rebuildList()
    updateHeader()
    markDirty()
end

function switchConversation(conv)
    if conv == S.activeConv then
        return
    end
    if S.generating or S.swapping then
        toast(T("toastWait"), true)
        return
    end
    S.editId = nil
    S.activeConv = conv
    renderConversation()
    rebuildList()
    updateHeader()
    markDirty()
end

function deleteConversation(conv)
    if S.generating or S.swapping then
        toast(T("toastWait"), true)
        return
    end
    for i, item in ipairs(S.conversations) do
        if item == conv then
            table.remove(S.conversations, i)
            break
        end
    end
    if #S.conversations == 0 then
        S.editId = nil
        S.activeConv = newConversation()
        renderConversation()
        markDirty()
    elseif conv == S.activeConv then
        S.editId = nil
        S.activeConv = S.conversations[1]
        renderConversation()
        markDirty()
    end
    saveHistoryDebounced()
    rebuildList()
    updateHeader()
    toast(T("toastDeleted"), false)
end

local function clearCurrentChat()
    if S.generating or S.swapping then
        toast(T("toastWait"), true)
        return
    end
    local conv = S.activeConv
    local hadHistory = #conv.history > 0
    conv.records = {}
    conv.history = {}
    conv.title = ""
    conv.updated = os.time()
    S.editId = nil
    saveHistoryDebounced()
    renderConversation()
    updateHeader()
    rebuildList()
    toast(T("toastCleared"), false)
    if hadHistory then
        markDirty()
    end
end

local function applyLanguage()
    refreshBound()
    if S.welcomeMsg and S.welcomeMsg.wrapper.Parent then
        S.welcomeMsg.text = T(S.welcomeKey)
        renderAi(S.welcomeMsg)
    end
    styleConnectButton()
    refreshControls()
    updateHeader()
    rebuildList()
end

function closeMoreMenu()
    if S.moreOpen then
        S.moreOpen = false
        GUI.moreMenuCard.Visible = false
    end
end

function toggleMoreMenu()
    S.moreOpen = not S.moreOpen
    GUI.moreMenuCard.Visible = S.moreOpen
    if S.moreOpen then
        GUI.moreMenuCard.BackgroundTransparency = 1
        tween(GUI.moreMenuCard, 0.12, { BackgroundTransparency = 0 })
    end
end

createMenuItem(Icon.Pen, "renameChat", function()
    if GUI.titleBox.Visible then
        GUI.titleBox:ReleaseFocus()
        return
    end
    GUI.titleBox.Text = displayTitle(S.activeConv)
    GUI.titleBox.Visible = true
    GUI.titleLabel.Visible = false
    GUI.titleBox:CaptureFocus()
end)

createMenuItem(Icon.Clear, "clearChat", clearCurrentChat)

createMenuItem(Icon.Globe, "switchLang", function()
    S.lang = S.lang == "en" and "id" or "en"
    applyLanguage()
    saveHistoryDebounced()
    toast(T("toastLanguage"), false)
end)

createMenuItem(Icon.NewChat, "newChat", startNewChat)

createContextMenuItem(Icon.Pen, "renameChat", function()
    local conv = S.contextMenuConv
    if conv then
        switchConversation(conv)
        GUI.titleBox.Text = displayTitle(conv)
        GUI.titleBox.Visible = true
        GUI.titleLabel.Visible = false
        GUI.titleBox:CaptureFocus()
    end
end)

createContextMenuItem(Icon.Trash, "deleteChat", function()
    local conv = S.contextMenuConv
    if conv then
        deleteConversation(conv)
    end
end)

local function setSidebar(open)
    S.sidebarOpen = open
    local width = open and CONFIG.UI.SIDEBAR_WIDTH or 0
    if open then
        GUI.sidebar.Visible = true
    end
    tween(GUI.chatArea, 0.2, {
        Position = UDim2.new(0, width, 0, 0),
        Size = UDim2.new(1, -width, 1, 0),
    })
    tween(GUI.sidebar, 0.2, { Position = UDim2.new(0, open and 0 or -CONFIG.UI.SIDEBAR_WIDTH, 0, 0) })
    if not open then
        task.delay(0.22, function()
            if S.alive and not S.sidebarOpen then
                GUI.sidebar.Visible = false
            end
        end)
    end
end

local function setPanelOpen(open)
    if open == S.panelOpen then
        return
    end
    S.panelOpen = open
    S.panelToken = S.panelToken + 1
    local mine = S.panelToken
    if open then
        GUI.openBtn.Visible = false
        GUI.main.GroupTransparency = 1
        GUI.panel.Visible = true
        tween(GUI.main, 0.18, { GroupTransparency = 0 })
    else
        GUI.inputBox:ReleaseFocus()
        GUI.confirmOverlay.Visible = false
        closeMoreMenu()
        GUI.contextMenu.Visible = false
        tween(GUI.main, 0.18, { GroupTransparency = 1 })
        GUI.openBtn.ImageTransparency = 1
        GUI.openBtn.BackgroundTransparency = 1
        GUI.openBtn.Visible = true
        tween(GUI.openBtn, 0.2, { ImageTransparency = 0, BackgroundTransparency = 0 })
        task.delay(0.2, function()
            if S.alive and mine == S.panelToken and not S.panelOpen then
                GUI.panel.Visible = false
            end
        end)
    end
end

local cleanup
cleanup = function()
    if not S.alive then
        return
    end
    S.alive = false
    S.userRequestedDisconnect = true
    S.queue = {}
    S.sessionId = S.sessionId + 1
    saveHistory()
    closeSocket()
    if S.turn then
        local t = S.turn
        S.turn = nil
        stopTyping(t.msg)
    end
    for t in pairs(S.activeTweens) do
        pcall(function()
            t:Cancel()
        end)
    end
    S.activeTweens = {}
    for t in pairs(S.loopTweens) do
        pcall(function()
            t:Cancel()
        end)
    end
    S.loopTweens = {}
    for _, conn in ipairs(S.connections) do
        pcall(function()
            conn:Disconnect()
        end)
    end
    S.connections = {}
    S.bound = {}
    S.apiKey = ""
    S.conversations = {}
    S.activeConv = nil
    if GUI.screenGui then
        pcall(function()
            GUI.screenGui:Destroy()
        end)
    end
    if genv.GeminiChatCleanup == cleanup then
        genv.GeminiChatCleanup = nil
    end
end
genv.GeminiChatCleanup = cleanup

on(GUI.connectBtn.MouseButton1Click, function()
    if S.state == "connected" or S.state == "connecting" then
        disconnect()
    else
        S.announce = true
        connect()
    end
end)

local function pointInside(gui, point)
    local pos = gui.AbsolutePosition
    local size = gui.AbsoluteSize
    return point.X >= pos.X and point.X <= pos.X + size.X and point.Y >= pos.Y and point.Y <= pos.Y + size.Y
end

local function pointerHits(gui, input)
    if not gui or not gui.Parent or not gui.Visible then
        return false
    end
    local point = Vector2.new(input.Position.X, input.Position.Y)
    local inset = GuiService:GetGuiInset()
    return pointInside(gui, point) or pointInside(gui, Vector2.new(point.X, point.Y + inset.Y))
end

on(UserInputService.InputBegan, function(input)
    if not isPointer(input) then
        return
    end
    if S.moreOpen and not pointerHits(GUI.moreMenuCard, input) and not pointerHits(GUI.moreBtn, input) then
        closeMoreMenu()
    end
    if GUI.contextMenu.Visible and not pointerHits(GUI.contextMenu, input) and not pointerHits(S.contextTrigger, input) then
        GUI.contextMenu.Visible = false
    end
end)

on(GUI.sendBtn.MouseButton1Click, sendMessage)
on(GUI.newChatBtn.MouseButton1Click, startNewChat)
on(GUI.moreBtn.MouseButton1Click, toggleMoreMenu)
on(GUI.backBtn.MouseButton1Click, function()
    setPanelOpen(false)
end)
on(GUI.closeBtn.MouseButton1Click, function()
    GUI.confirmOverlay.Visible = true
end)
on(GUI.confirmCancel.MouseButton1Click, function()
    GUI.confirmOverlay.Visible = false
end)
on(GUI.confirmClose.MouseButton1Click, cleanup)
on(GUI.manualClose.MouseButton1Click, function()
    GUI.manualOverlay.Visible = false
end)
on(GUI.menuBtn.MouseButton1Click, function()
    setSidebar(not S.sidebarOpen)
end)

on(GUI.searchBtn.MouseButton1Click, function()
    local show = not GUI.searchFrame.Visible
    GUI.searchFrame.Visible = show
    GUI.explorerLabel.Visible = not show
    if show then
        GUI.searchBox:CaptureFocus()
    else
        GUI.searchBox.Text = ""
        rebuildList()
    end
end)

on(GUI.searchBox:GetPropertyChangedSignal("Text"), rebuildList)

on(GUI.titleBox.FocusLost, function()
    local value = trim(GUI.titleBox.Text)
    if value ~= "" and S.activeConv then
        S.activeConv.title = string.sub(value, 1, 40)
        rebuildList()
        saveHistoryDebounced()
        toast(T("toastRenamed"), false)
    end
    GUI.titleBox.Visible = false
    GUI.titleLabel.Visible = true
    updateHeader()
end)

on(GUI.inputBox.Focused, function()
    tween(GUI.inputStroke, 0.15, { Transparency = 0 })
    closeMoreMenu()
    GUI.contextMenu.Visible = false
end)

on(GUI.inputBox.FocusLost, function()
    tween(GUI.inputStroke, 0.15, { Transparency = 0.65 })
end)

on(GUI.inputBox:GetPropertyChangedSignal("Text"), function()
    updateInputHeight()
    if S.enterGuard then
        return
    end
    local text = GUI.inputBox.Text
    local enterDown = UserInputService:IsKeyDown(Enum.KeyCode.Return)
        or UserInputService:IsKeyDown(Enum.KeyCode.KeypadEnter)
    local shiftDown = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
        or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
    if not enterDown or shiftDown then
        return
    end
    local cursor = GUI.inputBox.CursorPosition
    local cleaned
    if cursor > 1 and text:sub(cursor - 1, cursor - 1) == "\n" then
        cleaned = text:sub(1, cursor - 2) .. text:sub(cursor)
    elseif text:sub(-1) == "\n" then
        cleaned = text:sub(1, -2)
    else
        return
    end
    S.enterGuard = true
    GUI.inputBox.Text = cleaned
    S.enterGuard = false
    updateInputHeight()
    sendMessage()
end)

local function makeDraggable(handle)
    on(handle.InputBegan, function(input)
        if isPointer(input) then
            closeMoreMenu()
            GUI.contextMenu.Visible = false
            S.dragging = true
            S.dragStart = input.Position
            S.startPosition = GUI.panel.Position
            local changed
            changed = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    S.dragging = false
                    changed:Disconnect()
                end
            end)
        end
    end)
end

makeDraggable(GUI.header)
makeDraggable(GUI.brandBar)

on(GUI.resizeHandle.InputBegan, function(input)
    if isPointer(input) then
        closeMoreMenu()
        GUI.contextMenu.Visible = false
        S.resizing = true
        S.resizeStart = Vector2.new(input.Position.X, input.Position.Y)
        S.resizeOrigin = Vector2.new(GUI.panel.Size.X.Offset, GUI.panel.Size.Y.Offset)
        local changed
        changed = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                S.resizing = false
                changed:Disconnect()
            end
        end)
    end
end)

on(GUI.openBtn.InputBegan, function(input)
    if isPointer(input) then
        S.openDrag = { start = input.Position, origin = GUI.openBtn.Position, moved = false }
        local changed
        changed = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                local drag = S.openDrag
                S.openDrag = nil
                changed:Disconnect()
                if drag and not drag.moved then
                    setPanelOpen(true)
                end
            end
        end)
    end
end)

on(UserInputService.InputChanged, function(input)
    local moving = input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    if not moving then
        return
    end
    if S.openDrag then
        local drag = S.openDrag
        local delta = input.Position - drag.start
        if delta.Magnitude > 4 then
            drag.moved = true
        end
        if drag.moved then
            GUI.openBtn.Position = UDim2.new(
                drag.origin.X.Scale,
                drag.origin.X.Offset + delta.X,
                drag.origin.Y.Scale,
                drag.origin.Y.Offset + delta.Y
            )
        end
    end
    if S.dragging then
        local delta = input.Position - S.dragStart
        local sp = S.startPosition
        GUI.panel.Position = UDim2.new(
            sp.X.Scale,
            sp.X.Offset + delta.X,
            sp.Y.Scale,
            sp.Y.Offset + delta.Y
        )
    elseif S.resizing then
        local width = math.clamp(S.resizeOrigin.X + (input.Position.X - S.resizeStart.X), CONFIG.UI.MIN_WIDTH, CONFIG.UI.MAX_WIDTH)
        local height = math.clamp(S.resizeOrigin.Y + (input.Position.Y - S.resizeStart.Y), CONFIG.UI.MIN_HEIGHT, CONFIG.UI.MAX_HEIGHT)
        GUI.panel.Size = UDim2.new(0, width, 0, height)
    end
end)

local function layoutSidebar()
    local available = GUI.sidebar.AbsoluteSize.Y - CONFIG.UI.SIDEBAR_LIST_TOP - GUI.bottomBlock.AbsoluteSize.Y - CONFIG.UI.SIDEBAR_MARGIN - 4
    GUI.chatList.Size = UDim2.new(1, -CONFIG.UI.SIDEBAR_MARGIN * 2, 0, math.max(0, available))
end

on(GUI.sidebar:GetPropertyChangedSignal("AbsoluteSize"), layoutSidebar)
on(GUI.bottomBlock:GetPropertyChangedSignal("AbsoluteSize"), layoutSidebar)

on(GUI.screenGui.Destroying, cleanup)

styleButton(GUI.openBtn)

S.apiKey = loadApiKey()
S.activeConv = newConversation()

setState("disconnected")
rebuildList()
updateHeader()
renderConversation()
layoutSidebar()
updateInputHeight()
