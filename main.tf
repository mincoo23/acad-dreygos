provider ‘aws’ {
    region = ‘us-west-2’
}

resource ‘aws-instance’ ‘acad-dreygos-ec2-terraform’ {
    ami = ‘ami-408c7f28’
    Instance_type = ’t2.micro’
    Tags = {
        Name = ’acad-dreygos-ec2-terraform’
    }
}
