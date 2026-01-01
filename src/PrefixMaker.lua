function CreateUI()

    local result = MessageBox({
        title = "PrefixMaker",
        inputs = {
            { name = "Objects", value = "" },
            { name = "Prefix", value = "" }
        },
        commands = {
            {
                name = "Cancel",
                value = 1
            },
            {
                name = "Create",
                value = 2
            }
        }
    })

    if result.result == 2 then
        return result.inputs["Objects"], result.inputs["Prefix"]
    end

    return nil
end

function Main()

    function string:startsWith(start)
        return self:sub(1, #start) == start
    end

    local result, prefix = CreateUI()
    if result == nil then
        Confirm("Error", "Objects cannot be empty")
        return
    end
    if prefix == nil then
        Confirm("Error", "Prefix cannot be empty.")
    end
    prefix = prefix

    Printf(result)
    Printf(prefix)
    local objects = ObjectList(result)
    if objects == nil or #objects == 0 then
        Confirm("Error", "No Objects found.")
        return
    end

    for i = 1, #objects do
       local object = objects[i]
       local objectName = object:Get("Name")

        if not objectName:startsWith(prefix) then
            object:Set("Name", prefix .. " - " .. objectName)
        end
    end
end

return Main;