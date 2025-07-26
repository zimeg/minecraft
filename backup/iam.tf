# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "minecraft" {
  name = "minecraft"
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_access_key
resource "aws_iam_access_key" "minecraft" {
  user = aws_iam_user.minecraft.name
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/datasources/iam_policy_document
data "aws_iam_policy_document" "minecraft_policy" {
  statement {
    sid    = "AllowListBucket"
    effect = "Allow"

    actions = ["s3:ListBucket"]
    resources = [
      "arn:aws:s3:::architectf",
      "arn:aws:s3:::tom.25565",
    ]
  }

  statement {
    sid    = "AllowSpecificObject"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      "arn:aws:s3:::architectf/minecraft",
      "arn:aws:s3:::tom.25565/*",
    ]
  }

  statement {
    sid    = "AllowSpecificDynamoTable"
    effect = "Allow"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      "arn:aws:dynamodb:us-east-1:*:table/architectf-timeline"
    ]
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "minecraft" {
  name   = "minecraft"
  policy = data.aws_iam_policy_document.minecraft_policy.json
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment
resource "aws_iam_user_policy_attachment" "minecraft" {
  user       = aws_iam_user.minecraft.name
  policy_arn = aws_iam_policy.minecraft.arn
}

# https://opentofu.org/docs/language/values/outputs/
output "minecraft_access_key" {
  value     = aws_iam_access_key.minecraft.id
  sensitive = true
}

# https://opentofu.org/docs/language/values/outputs/
output "minecraft_secret_access_key" {
  value     = aws_iam_access_key.minecraft.secret
  sensitive = true
}
