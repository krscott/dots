require("krisvim.remap")
require("krisvim.options")
require("krisvim.jumplist")

function dumps(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dumps(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
