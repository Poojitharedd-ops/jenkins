Jenkins is a powerful open-source automation server that helps streamline CI/CD workflows. If you're working with RHEL 9, follow this step-by-step guide to get Jenkins up and running.

✅ Step 1: Install Java (Required for Jenkins)
Jenkins requires Java 11 or 17. First, check if Java is installed:

java -version
If Java is missing, install OpenJDK:

sudo dnf install -y java-17-openjdk
Verify the installation:

java -version
✅ Step 2: Add the Jenkins Repository
Jenkins is not available in default RHEL repositories, so we need to add it manually.

🔹 Enable EPEL Repository:

sudo dnf install -y epel-release
🔹 Create a Jenkins repo file:

sudo tee /etc/yum.repos.d/jenkins.repo <<EOF [jenkins] name=Jenkins-stable baseurl=https://pkg.jenkins.io/redhat-stable gpgcheck=1 gpgkey=https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key EOF
🔹 Import Jenkins GPG Key:

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key


🔹 Verify the repository was added:

dnf repolist
✅ Step 3: Install Jenkins
Install Jenkins with the following command:

sudo dnf install -y jenkins
✅ Step 4: Enable & Start Jenkins
Enable Jenkins to start on boot and launch the service:

sudo systemctl enable --now jenkins
Check if Jenkins is running:

sudo systemctl status jenkins
You should see "active (running)" in the output.

✅ Step 5: Open Firewall for Jenkins (Port 8080)
By default, Jenkins runs on port 8080. If your firewall is active, allow access:

🔹 Check firewall status:

sudo systemctl status firewalld
If it is inactive, you can skip this step.

🔹 If active, open port 8080:

sudo firewall-cmd --permanent --add-port=8080/tcp sudo firewall-cmd --reload
🔹 Verify the rule was added:

sudo firewall-cmd --list-ports
You should see 8080/tcp in the output.

✅ Step 6: Configure AWS Security Groups (If Using AWS)
If your Jenkins server is on an AWS EC2 instance, you need to allow port 8080:

1️⃣ Go to AWS Console → EC2 Dashboard 2️⃣ Select your instance 3️⃣ Click on Security Groups 4️⃣ Click Edit inbound rules → Add Rule

Protocol: TCP
Port Range: 8080
Source: 0.0.0.0/0 (or restrict to your IP) 5️⃣ Click Save Rules

✅ Step 7: Access Jenkins
Once Jenkins is running, open your browser and go to:

http://<your-server-ip>:8080
To find your server IP:

ip a | grep inet
🔑 You’ll be prompted for the initial admin password. Retrieve it using:

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Copy this password and complete the setup wizard. 🎉

🚀 Final Thoughts
🎊 Congratulations! You have successfully installed Jenkins on RHEL 9. Now, you can start setting up CI/CD pipelines and automate your software development workflow!

💡 Did you find this guide helpful? Drop a comment below! 💬 🔹 Follow me for more DevOps tips & tutorials! 🚀
