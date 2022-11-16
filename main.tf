terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
#simulando mais de uma região
provider "aws" {
  region = "us-west-2"
}
provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}
#instancias de simulação
resource "aws_instance" "dev" {
  count         = 3
  ami           = "ami-017fecd1353bcc96e"
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"] #referencia usar ${algumas coisa.id}
}

resource "aws_instance" "dev4" { #instancia que vincula bucket edwardlabs-dev4
  ami           = "ami-017fecd1353bcc96e"
  instance_type = "t2.micro"
  key_name      = "testeiac"

  tags = {
    Name = "dev4"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]

  depends_on = [aws_s3_bucket.dev4]

}

resource "aws_instance" "dev5" {
  provider      = "aws.us-west-1"
  ami           = var.amis["us-west-1"]
  instance_type = "t2.micro"
  key_name      = var.key_name2

  tags = {
    Name = "dev5"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-west-1.id}"]
}

resource "aws_instance" "dev6" {
  provider      = "aws.us-west-1"       #recurso para determinar a região diferente
  ami           = var.amis["us-west-1"] #variavel tipo map
  instance_type = "t2.micro"
  key_name      = var.key_name2

  tags = {
    Name = "dev6"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-west-1.id}"]
  depends_on             = [aws_dynamodb_table.dynamodb-homologacao]
}

resource "aws_instance" "dev7" {
  provider      = "aws.us-west-1"
  ami           = var.amis["us-west-1"]
  instance_type = "t2.micro"
  key_name      = var.key_name2
  tags = {
    Name = "dev7"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-west-1.id}"]
}


#database dynamoDBtables
resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider     = "aws.us-west-1"
  name         = "GameScores"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}  