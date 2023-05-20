resource "aws_instance" "foo" {
    ami           = "ami-02eb7a4783e7e9317" # ap-south-1
    instance_type = "t2.micro"
    availability_zone = "ap-south-1b"
    key_name = "test"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.allow_all.id]
    associate_public_ip_address = true

    tags = {
        Name = "mongo-db"
    }
}

resource "null_resource" "execute" {

    connection {
        type = "ssh"
        host = aws_instance.foo.public_ip
        user = "ubuntu"
        private_key = "${file("test.pem")}"
    }

    provisioner "local-exec" {
    command = "echo '${aws_instance.foo.public_ip}' > instance_ip.txt"
    }


    provisioner "remote-exec" {
        inline = [
        "sleep 60",
        "sudo apt-get update -y",
        "sleep 20",
        "sudo curl https://get.docker.com | bash",
        "sudo apt-get install gnupg",
        "curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
           sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg \
            --dearmor"
        "echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list",
        "sudo apt-get update",
        "sudo apt-get install -y mongodb-org",
        "sudo systemctl start mongod",
        "mongosh",
        "use test",
        "db.createCollection("mycollection")",
        "db.createUser({ user: "admin", pwd: "admin123", roles: [] })",
        ]
    }
    depends_on = [aws_instance.foo]
  
}







