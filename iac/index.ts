import * as aws from "@pulumi/aws";

// Create an AWS resource (S3 Bucket)
const bucket = new aws.s3.Bucket("primeiro-teste-pos-ftr", {
  tags: {
    IAC: "true",
  },
});

// Export the name of the bucket
export const bucketName = bucket.id;
