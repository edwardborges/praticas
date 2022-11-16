variable "amis" {
  type = map(string)

  default = {
    "us-west-2" = "ami-017fecd1353bcc96e"
    "us-west-1" = "ami-017c001a88dd93847"
  }

}

variable "cdirs_acesso_remote" {
  type = list(any)

  default = ["201.17.0.0/16"]


}

variable "key_name" {
  type    = string
  default = "testeiac"

}

variable "key_name2" {
  type    = string
  default = "testeiac2"

}