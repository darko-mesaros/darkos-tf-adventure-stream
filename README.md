# Darko's Terraform Adventure

![header](/assets/githubheader.png)

If you are stumbling onto this repository looking for an awesome Terraform
project, you **may** be in the wrong place. But in any case, welcome! This
repository serves as a single point of reference for a
[series](https://www.youtube.com/playlist?list=PLbTckSyY9fPYgIYnIAfHmhyXLAHHCQ8LA)
of Twitch/Youtube streams that I am doing on the topic of Terraform.

Here is the gist of it:
I am, by no means, an expert in Terraform - and by that I mean, I've tried it
once. So I use this opportunity to learn Terraform and share my learning path
with the wider community.

I will be spliting the updates here based on episodes or parts of the stream so
its easier to follow.
Make sure to join me the streams I do every week - the topics of those streams
are revolving around AWS and Cloud Technologies, but do expect a lot of code
and fun stuff as well.

**Contact info:**

- [Twitch](https://twitch.tv/ruptwelve)
- [YouTube](https://youtube.com/ruptwelve)
- [Twitter](https://twitter.com/darkosubotica)

## Episode 01

Link to the [YouTube video](https://youtu.be/4zvueYsCcoo).

In the first episode we were going down with the basics:

- Installing Terraform on my laptop
- Creating our first `hello_world` application/project.

On top of just doing the simple `hello_world` example, we expanded on it and did
some modifications.
What can you expect from the code here is:

- That we have created a VPC with a subnet.
- A single EC2 instance running Amazon Linux 2
- That EC2 instance is running as a Web Server - to be precise it has Apache
  running on it.

## Episode 02

Link to the [YouTube video](https://youtu.be/iCKKFeJoWHw).

In the second episode we were looking at some more advanced aspects of
Terraform:

- Implemented Variables to our templates so that we can change some certain
  aspects of our infrastructure without hardcoding it.
- Creating outputs - so that we may be presented with the IP address of our web
  server immediately after the creation.
- The all important Terraform State file - a file that, last time, we had on our
  workstation - we now moved to a shared location (Amazon S3) so that it can
  remain in a safe place and is able to be used from multiple locations.

Only a minor change was done to the AWS side of things. In order to be able to
access our instance remotely (via [AWS Systems Manager Session
Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html),
we have created and attached an instance Profile to the EC2 instance. On top of
that we fixed our bootstrap procedure to actually enable the Apache service,
instead of just starting it.

The output of Episode two is the following:

- A single EC2 instance running Apache web server (no app yet tho).
- The instance is running in its own VPC
- There is an IAM instance profile created and attached to the EC2 so that it
  may be managed by AWS Systems Manager (connect to it via Session Manager)

## Episode 03

Link to the [YouTube video](https://youtu.be/iCKKFeJoWHw).

In the third episode of the streaming series we expanded our AWS Setup a bit.
That is, we moved away from using a single EC2 instance as a Web Server, to
using an AWS Auto Scaling group. I've struggled a bit with some IAM instance
profile parameter consistency, but I figured it out later on via the Terraform
docs.

Here is what we have done in Episode three:

- Transitioned from an EC2 instance to an AWS Auto Scaling group, so we can have
  a cluster of web servers available for us.
- Added an Application Load Balancer in front of the instances in that Auto
  Scaling group so that the network traffic can go to either of the web servers
  launched.

One thing to **note** from this episode, I had to hardcode the VPC Subnets to
the LoadBalancer, as I could not find a dynamic way of doing this in Terraform -
so this is still pending.

The output of Episode three is the following:

- Web servers that are launched from an AWS Auto Scaling group (3 in total)
- Application Load balancer that sits in front of the Web servers
- VPC, Subnets, and the rest of the Network stuff
- IAM Permissions (IAM Instance role) that allow our instance to be managed by
  AWS Systems Manager.

```terraform
# More to come
```
