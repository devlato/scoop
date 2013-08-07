$bucketsdir = "$scoopdir\buckets"

function bucketdir($name) {
    "$bucketsdir\$name"
}

<#
# convert an object to a hashtable
function hashtable($obj) {
    $h = @{ }
    $obj.psobject.properties | % {
        $h[$_.name] = hashtable_val($_.value);
    }
    return $h
}
function hashtable_val($obj) {
    if($obj -is [object[]]) {
        return $_.value | % { hashtable_val($_) }
    }
    if($obj.gettype().name -eq 'pscustomobject') { # -is is unreliable
        return hashtable($obj)
    }
    return $obj # assume primitive
}
#>