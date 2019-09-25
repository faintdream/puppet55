node default {
 notify {"If you see me, the communcation with puppet master is working ! ":
 }
}

node 'node.example.com'{
 include buildtools
 notice("Hello from node config")
}
