-- Скрипт для Redis: получение всех ключей активных сессий
-- (В Redis ключи сессий обычно выглядят как "session:uuid")

local keys = redis.call('KEYS', 'session:*')
local result = {}

-- Проходимся по всем найденным сессиям
for i, key in ipairs(keys) do
    -- В твоей системе значение сессии - это user_id
    local user_id = redis.call('GET', key)
    if user_id then
        -- Формируем строку: "session_id -> user_id"
        table.insert(result, key .. " -> user_id: " .. user_id)
    end
end

return result
