provider "aws" {
    region     = "${var.region}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}

#################### Creating 4 IAM Users ######################
resource "aws_iam_user" "user1" {
  name = "Jane"
  path = "/"
  tags = {
    tag-key = "Dev-Team"
  }
}
resource "aws_iam_user" "user2" {
  name = "Peter"
  path = "/"
  tags = {
    tag-key = "Dev-Team"
  }
}
resource "aws_iam_user" "user3" {
  name = "Paul"
  path = "/"
  tags = {
    tag-key = "Finance-Team"
  }
}
resource "aws_iam_user" "user4" {
  name = "Zippy"
  path = "/"
  tags = {
    tag-key = "Finance-Team"
  }
}

####################  Create New IAM Group and add IAM Users ######################
resource "aws_iam_group" "group1" {
  name = "DevTeam"
}
resource "aws_iam_group_membership" "member1" {
  name = "user1"
  users = [
    aws_iam_user.user1.name,
    aws_iam_user.user2.name,
  ]
  group = aws_iam_group.group1.name
}
resource "aws_iam_group" "group2" {
  name = "FinanceTeam"
}
resource "aws_iam_group_membership" "member2" {
  name = "user2"
  users = [
    aws_iam_user.user3.name,
    aws_iam_user.user4.name,
  ]
  group = aws_iam_group.group2.name
}

