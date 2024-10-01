provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "yash_sg" {
  name = "rds_sg"
  # Define ingress and egress rules for RDS
   # ssh for terraform remote exec
  ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
  }

}

resource "aws_instance" "name" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.medium"
  key_name = "yash"
  vpc_security_group_ids = [ "sg-0eeb0784489e96f24" ]
  tags = {
    Name = "jenkins2"
  }
  
provisioner "remote-exec" {
    inline = [
        "sudo apt-get update",
        "sudo apt-get upgrade -y",
        "sudo apt install python3-pip -y",
        "sudo apt install python3-venv -y",
        "sudo apt install python3-virtualenv -y",
        "python3 -m venv /home/ubuntu/kumar",
        ". /home/ubuntu/kumar/bin/activate",
        "git https://github.com/Nowpadasiri/mymart28-08-2024.git",
        "cd mymart28-08-2024",
        "sudo apt install openjdk-17-jdk -y",
        "sudo apt install maven -y",
        "sudo apt install gradle -y",
        "sudo apt install spring -y",
        "mvn clean package",
        "java -jar target/MyMart-0.0.1-SNAPSHOT.jar"
    
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"  
      private_key = file("yash.pem")  
      host     = self.public_ip  
    }
 }
}
