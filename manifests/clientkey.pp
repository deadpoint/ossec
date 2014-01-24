#
define ossec::clientkey (
    $client_id,
    $client_name,
    $client_ip,
    $client_seed    = "BbmV4LNOnyW7"
    ) {

    include amanda::params

    $key1 = md5("${client_id} ${client_seed}")
    $key2 = md5("${client_name} ${client_ip} ${client_seed}")

    #notify { "key1": message => "key1 = $key1" }
    #notify { "key2": message => "key2 = $key2" }
    #notify { "content": message => "${client_id} ${client_name} ${client_ip} ${key1}${key2}\n"}
    concat::fragment { "ossec-client-key-${client_ip}":
        ensure  => present,
        target  => "$ossec::params::client_keys",
        order   => "${client_id}",
        content => "${client_id} ${client_name} ${client_ip} ${key1}${key2}\n",
    }
}
