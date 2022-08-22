log = {}


function log:info(text)
    print("[INFO]   "..text)
end

function log:error(text)
    print('[ERROR]  '..text)
end

function log:warning(text)
    print("[WARN]   "..text)
end