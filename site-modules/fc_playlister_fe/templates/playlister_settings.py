db_cluster_ips = '<%= scope['fc_playlister_fe::oltp_ips'] %>'
db_cluster_vip = '<%= scope['fc_playlister_fe::oltp_vip'] %>'
database = '<%= scope['fc_playlister_fe::database'] %>'
username = '<%= scope['fc_playlister_fe::username'] %>'
password = '<%= scope['fc_playlister_fe::password'] %>'

db_cluster_ips = db_cluster_ips.split(',')
