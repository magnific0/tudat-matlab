function jsonObject = encode(object,tabsize)

if nargin < 2
    tabsize = 2;
end

% Convert to json (only if not json)
try
    object = jsondecode(object);
catch
end

% Fix bug of jsonencode function when combined with sprintf/fprintf for escaped / and "
jsonObject = strrep(strrep(jsonencode(json.struct(object)),'\/','/'),'\"','\\"');

% Add indenting
if tabsize > 0
    indentedjson = [];
    indentLevel = 0;
    betweenQuotes = -1;
    for i = 1:length(jsonObject)
        c = jsonObject(i);
        if c == '"'
            betweenQuotes = -betweenQuotes;
        end
        if betweenQuotes == 1
            indentedjson = sprintf('%s%s',indentedjson,c);
        else
            if c == '{' || c == '['
                indentLevel = indentLevel + 1;
                indentedjson = sprintf('%s%s\n',indentedjson,c);
                for j = 1:(tabsize*indentLevel)
                    indentedjson = sprintf('%s ',indentedjson);
                end
            elseif c == '}' || c == ']'
                indentLevel = indentLevel - 1;
                indentedjson = sprintf('%s\n',indentedjson);
                for j = 1:(tabsize*indentLevel)
                    indentedjson = sprintf('%s ',indentedjson);
                end
                indentedjson = sprintf('%s%s',indentedjson,c);
            elseif c == ','
                indentedjson = sprintf('%s%s\n',indentedjson,c);
                for j = 1:(tabsize*indentLevel)
                    indentedjson = sprintf('%s ',indentedjson);
                end
            elseif c == ':'
                indentedjson = sprintf('%s%s ',indentedjson,c);
            else
                indentedjson = sprintf('%s%s',indentedjson,c);
            end
        end
    end
    jsonObject = indentedjson;
end

end
