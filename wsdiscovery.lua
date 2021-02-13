WSDiscovery_proto = Proto("WSDiscovery","WSDiscovery","WSDiscovery protocol")

function WSDiscovery_proto.dissector(buffer,pinfo,tree)
    pinfo.cols.protocol = "WSDiscovery"
    pinfo.cols.info = "WSDiscovery"

    xml_dissector = Dissector.get("xml")
    xml_dissector:call(buffer,pinfo,tree)
end

DissectorTable.get("udp.port"):add(3702, WSDiscovery_proto);
