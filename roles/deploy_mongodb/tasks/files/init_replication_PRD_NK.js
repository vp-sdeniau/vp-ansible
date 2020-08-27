rs.initiate("MDB_PRD_NK")
sleep(8000)
rs.add({ host: "172.17.0.96:27017", priority: 2, votes: 1})
rs.add({ host: "172.17.0.97:27017", priority: 1, votes: 1})
rs.add({ host: "172.17.0.98:27017", priority: 0, votes: 1})
sleep(8000)
var cfg = rs.conf();
cfg.members[0].priority = 2
rs.reconfig(cfg)
