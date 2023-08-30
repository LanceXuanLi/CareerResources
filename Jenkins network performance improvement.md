# Setting Up Jenkins in China - The Latest Process
## Step 1: Downloading Jenkins
Click to access the [Tsinghua Jenkins Download Link](https://mirrors.tuna.tsinghua.edu.cn/jenkins/windows-stable/). We'll download version jenkins-2.204.2.zip.
Afterward, extract the files and proceed with installation.

## Step 2: Configure Administrator Password
Automatically open the browser to http://localhost:8080/login?from=%2F. This is where the configuration begins.
![](https://img2018.cnblogs.com/blog/1928212/202002/1928212-20200224205836241-1477241953.png)

Retrieve and input the password according to the provided path.

## Step 3: Configure Plugins
If you're in China, it's advisable to skip plugin installation due to potential download issues.
Click to skip the plugin installation.

## Step 4: Register an Account
You can create an account or use "admin". I opted to create an account.
![](https://img2018.cnblogs.com/blog/1928212/202002/1928212-20200224205848962-482353868.png)

Click "Next" after completing this step.

## Step 5: Configure Jenkins URL
I didn't modify this, but you can change the port number if needed. Keep in mind that changing the port requires modifying the configuration file; many blogs explain how to handle port changes.
![](https://img2018.cnblogs.com/blog/1928212/202002/1928212-20200224205904040-1706997813.png)

Click "Save and Finish", then you'll see the welcome image.
![](https://img2018.cnblogs.com/blog/1928212/202002/1928212-20200224205919258-801001597.png)

## Modifying Plugin Source
Click "Manage Jenkins" -> "Manage Plugins".
![](https://img2018.cnblogs.com/blog/1928212/202002/1928212-20200224205933391-2083174971.png)

Click "Advance".
![](https://img2018.cnblogs.com/blog/1928212/202002/1928212-20200224205949374-1610091471.png)

Scroll down to find "Update Site". In the URL under "Update Site", input:
`http://mirrors.tuna.tsinghua.edu.cn/jenkins/updates/update-center.json`
Then click "Submit" and subsequently "Check Now" at the bottom-right corner.
![](https://img2018.cnblogs.com/blog/1928212/202002/1928212-20200224210001871-102668077.png)

**At this point, many blogs stop, yet you'll still notice slow download speeds.**
Therefore, you need to address this issue:
Open the "updates" folder in Jenkins' installation directory (mine is `D:\app\jenkins\updates`).
Open the `default.json` file and you'll find many URLs belonging to `https://www.google.com` and `http://updates.jenkins-ci.org`. These are the reasons for slow or failed downloads, as one isn't accessible in China and the other is slow.
You need to replace these URLs.
Using any text editor, replace all instances of `https://www.google.com` with `https://www.baidu.com`, and replace `http://updates.jenkins-ci.org` with `https://mirrors.tuna.tsinghua.edu.cn/jenkins`. Save the file.
**Remember, after saving, do not click "Check Now". If you do, the URLs will revert to Google's sites.**

## Installing Plugins
Click "Manage Jenkins" -> "Manage Plugins" -> "Available".
![](https://img2018.cnblogs.com/blog/1928212/202002/1928212-20200224210009953-478184678.png)

Install the plugins according to the list provided on this [Plugin Site](https://www.cnblogs.com/zhanglianghhh/archive/2018/10/11/9770529.html). You'll find other content there, but for now, you'll notice significantly improved speeds.
## Subsequent Tasks
Other aspects have been comprehensively covered by other bloggers. Depending on your needs, refer to other bloggers' content and install the required plugins accordingly.

Please note that this is a translated version of the provided markdown content. If you have any further questions or adjustments, feel free to let me know!
