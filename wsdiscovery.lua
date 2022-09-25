-------------------------------------------------------------------------------------------
-- This is a wireshark dissector for WS-Discovery.
--
-- See http://docs.oasis-open.org/ws-dd/discovery/1.1/wsdd-discovery-1.1-spec.html
--
-------------------------------------------------------------------------------------------
-- See https://wiki.wireshark.org/Lua/Examples
--
-- How to install this plugin on Windows
--     mkdir %APPDATA%\Wireshark\plugins
--     copy this file to %APPDATA%\Wireshark\plugins
--
-- See https://www.wireshark.org/docs/wsug_html_chunked/ChPluginFolders.html
-------------------------------------------------------------------------------------------
WSDiscovery_proto = Proto("WSDiscovery","WSDiscovery","WSDiscovery protocol")

function WSDiscovery_proto.dissector(buffer,pinfo,tree)
    local soapString = buffer():string(ENC_UTF_8)
    local action, tag = string.match(soapString, "http://schemas.xmlsoap.org/ws/2005/04/discovery/(%w+)</([^>]+)>")

    if action == nil then
        action = 'unknown'
    end

    pinfo.cols.protocol = "WSDiscovery"
    pinfo.cols.info:set("WSDiscovery: " .. action)

    xml_dissector = Dissector.get("xml")
    xml_dissector:call(buffer,pinfo,tree)
end

DissectorTable.get("udp.port"):add(3702, WSDiscovery_proto);
