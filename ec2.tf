# Launch template for EC2 with Nginx
resource "aws_launch_template" "web" {
  name_prefix   = "web-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = "showcase"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash -xe
              # Redirect stdout/stderr to a log file and system logger
              exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

              echo "Starting user_data script execution"

              yum update -y
              echo "yum update completed"

              amazon-linux-extras install nginx1.12 -y
              echo "yum install nginx completed"
              
              # Create informative HTML page
              echo "<html>" > /usr/share/nginx/html/index.html
              echo "<head>" >> /usr/share/nginx/html/index.html
              echo "  <title>AWS Infrastructure Showcase</title>" >> /usr/share/nginx/html/index.html
              echo "  <style>" >> /usr/share/nginx/html/index.html
              echo "    body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }" >> /usr/share/nginx/html/index.html
              echo "    .section { margin-bottom: 20px; }" >> /usr/share/nginx/html/index.html
              echo "    .highlight { background-color: #f0f0f0; padding: 10px; border-radius: 5px; }" >> /usr/share/nginx/html/index.html
              echo "  </style>" >> /usr/share/nginx/html/index.html
              echo "</head>" >> /usr/share/nginx/html/index.html
              echo "<body>" >> /usr/share/nginx/html/index.html
              echo "  <h1>AWS Infrastructure Showcase</h1>" >> /usr/share/nginx/html/index.html
              echo "  <div class='section'>" >> /usr/share/nginx/html/index.html
              echo "    <h2>What's Running Here?</h2>" >> /usr/share/nginx/html/index.html
              echo "    <p>This web server was created using Terraform and includes:</p>" >> /usr/share/nginx/html/index.html
              echo "    <ul>" >> /usr/share/nginx/html/index.html
              echo "      <li>EC2 Instance (t2.micro)</li>" >> /usr/share/nginx/html/index.html
              echo "      <li>Application Load Balancer (ALB)</li>" >> /usr/share/nginx/html/index.html
              echo "      <li>Security Group with HTTP access</li>" >> /usr/share/nginx/html/index.html
              echo "    </ul>" >> /usr/share/nginx/html/index.html
              echo "  </div>" >> /usr/share/nginx/html/index.html
              echo "  <div class='section'>" >> /usr/share/nginx/html/index.html
              echo "    <h2>Instance Details</h2>" >> /usr/share/nginx/html/index.html
              echo "    <div class='highlight'>" >> /usr/share/nginx/html/index.html
              echo "      <p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>" >> /usr/share/nginx/html/index.html
              echo "      <p>Region: $(curl -s http://169.254.169.254/latest/meta-data/placement/region)</p>" >> /usr/share/nginx/html/index.html
              echo "    </div>" >> /usr/share/nginx/html/index.html
              echo "  </div>" >> /usr/share/nginx/html/index.html
              echo "  <div class='section'>" >> /usr/share/nginx/html/index.html
              echo "    <h2>How It Works</h2>" >> /usr/share/nginx/html/index.html
              echo "    <p>This infrastructure was created using Terraform, an infrastructure as code tool that allows us to:</p>" >> /usr/share/nginx/html/index.html
              echo "    <ul>" >> /usr/share/nginx/html/index.html
              echo "      <li>Define infrastructure in code</li>" >> /usr/share/nginx/html/index.html
              echo "      <li>Track infrastructure changes</li>" >> /usr/share/nginx/html/index.html
              echo "      <li>Automate infrastructure deployment</li>" >> /usr/share/nginx/html/index.html
              echo "    </ul>" >> /usr/share/nginx/html/index.html
              echo "  </div>" >> /usr/share/nginx/html/index.html
              echo "</body></html>" >> /usr/share/nginx/html/index.html
              
              # Start Nginx
              systemctl start nginx
              echo "systemctl start nginx completed"
              systemctl enable nginx
              echo "systemctl enable nginx completed"

              systemctl status nginx || echo "Nginx status check failed"
              echo "User_data script finished"
              EOF
  )
}
