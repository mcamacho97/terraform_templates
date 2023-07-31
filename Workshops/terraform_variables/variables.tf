variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

# Example of List variable
variable "Security_Group" {
  type    = list(string)
  default = ["sg-24076", "sg-90890", "sg-456789"]
}

# Example of Map variable
variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0af9d24bd5539d7af"
    us-east-2 = "ami-0a561b65214a47cac"
  }

}