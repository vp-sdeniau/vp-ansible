rs.initiate("MDB_REC_NK")
sleep(8000)
rs.add({ host: "172.28.1.26:27017", priority: 2, votes: 1})
rs.add({ host: "172.28.1.27:27017", priority: 1, votes: 1})
rs.add({ host: "172.28.1.28:27017", priority: 0, votes: 1})
sleep(8000)
var cfg = rs.conf();
cfg.members[0].priority = 2
rs.reconfig(cfg)
