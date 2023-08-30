# Solving the Issue of "PKIX path building failed"
> This article discusses the causes and solutions (both temporary and permanent) for the "PKIX path building failed" error. It also covers the difference between HTTP and HTTPS.

### A Layman's Explanation of "PKIX path building failed"
In simple terms, the "PKIX path building failed" error occurs when your Java environment lacks the certificates necessary for specific websites.

### Understanding "PKIX path building failed"

PKIX stands for Public-Key Infrastructure (X.509). According to Wikipedia, X.509 is a certificate standard widely used in various network protocols, including TLS/SSL. TLS/SSL, in turn, is a standard for HTTPS (the "S" in HTTPS refers to SSL), making it the focus of this article.

### In-Depth Explanation of TLS/SSL Protocol
Next, let's delve into the relationship between TLS and SSL, along with a detailed breakdown.
#### Relationship between TLS and SSL
- SSL (Secure Sockets Layer) is the predecessor to TLS (Transport Layer Security).
- TLS resides above the transport layer, while SSL lies between the transport layer and the application layer.
- SSL has three versions: SSL v1.0 (1995), SSL v2.0 (1995), and SSL v3.0 (1996).
- TLS has four versions: TLS v1.0 (1999), TLS v1.1 (2006), TLS v1.2 (2008), and TLS v1.3 (2018).
- SSL is the precursor to TLS and is not recommended for use. TLS v1.0 corrected security flaws in SSL v3.0, but the ability to downgrade to SSL v3.0 from TLS v1.0 still poses security risks (when accessing sites with lower TLS versions or any SSL version, browsers warn users, and continuing is discouraged).
#### TLS Handshake Process
- TLS Handshake
1. The Client sends a clientHello to the Server, containing:
    - Supported TLS versions
    - Cipher suite (a set of supported encryption algorithms)
    - Client random number
2. The Server responds with a ServerHello to the Client, containing:
    - Determined TLS version by the Server
    - Server random number
    - Chosen cipher suite
3. The Server sends its certificate message (including the server's public key) to the Client. Using a certificate ensures the correctness of the public key, as certificates are trusted by reputable authorities.
4. The Server sends a ServerHelloDone message to the Client, indicating the completion of the handshake.
5. The Client sends a ClientKeyExchange message to the Server, including:
    - PremasterSecret (contains a shared key encrypted using the server's public key).
Apart from this, the Client uses the server's random number, its own random number, and PremasterSecret to create a shared key.
6. The Server decrypts the ClientKeyExchange message using its private key and uses the server's random number, the client's random number, and PremasterSecret to form a shared key.
7. The Client sends a ChangeCipherSpec to the Server, indicating that the Server can start using the negotiated shared key. This includes:
    - Finished message: This is the hash or MAC value of the previous handshake information using an algorithm (message authentication code).
8. The Server receives ChangeCipherSpec, calculates its own content locally, checks if the received hash/MAC matches its calculation. If it doesn't match, the handshake fails; if it matches, the Server sends ChangeCipherSpec to the client, indicating the start of shared key usage.

### Detailed Explanation of Cipher Suite
Cipher suite is designed to ensure secure connection establishment. It consists of combinations of four algorithm primitives. During the handshake between the client and server, the server determines the algorithms to be used, and both client and server use these algorithms together.
- Four algorithm primitives (for a cipher suite, there can only be one Kx, one Au, one Enc, and one MAC, although these algorithms can be different):
    - Key Exchange (Kx): Common options include DH and ECDH (similar to the TLS handshake process).
    - Authentication (Au): Common options include DSA/RSA/ECDSA (certificates, such as the public key sent back by the server, which is part of the server's certificate; the client can verify the certificate's validity).
    - Encryption (Enc): Primarily AES (encryption algorithm related to cryptography, not discussed here).
    - Message Authentication Code (MAC): Common options include SHA1, SHA256, and SHA384 (a hash or message digest is computed over the message, serving as proof of message integrity and authenticity for the client).

##### Solution 1 (Not Recommended)
As previously mentioned, HTTPS websites utilize TLS/SSL, while PKIX is used within TLS/SSL. Therefore, you can work around the issue by replacing all instances of `https://····` with `http://····`.

##### Solution 2 (Recommended: Automatic SSL Filtering within Programs)
At times, such as when a mini-program needs to access a user's openid and session-key via `https://api.weixin.qq.com/sns/jscode2session`, using HTTP instead of HTTPS is not an option due to API restrictions. In such cases, we need to bypass SSL locally for network connections.
In my opinion, many hosts fail to execute required network connections if they lack SSL authentication. Hence, SSL filtering is necessary during software development.
You can use the following utility class:
![](https://img2020.cnblogs.com/blog/1928212/202003/1928212-20200307105440221-1646636271.png)

For the code, please visit

 [httpclient实现https请求 (HttpClient Implementation for HTTPS Requests)](https://blog.csdn.net/Cloud_July/article/details/73301805).

##### Solution 3 (Addressing PKIX Issues in Maven and More)
![](https://img2020.cnblogs.com/blog/1928212/202003/1928212-20200307105818338-1066320005.png)

In the specified position, add `-Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true`.

##### Solution 4 (Importing Certificates)
Many bloggers have used outdated syntax. I recommend checking the most recent import syntax using `keytool -help` when importing.
Access cmd in administrator mode and navigate to the `jre\lib\security` directory of your Java JDK.
Mine is located at `C:\Program Files\Java\jdk1.8.0_221\jre\lib\security`.
For instructions on obtaining certificates, refer to other bloggers; it's quite straightforward.
Use the following command to import the certificate:
```keytool -importcert -noprompt -trustcacerts -alias xxx (desired alias) -file "C:\Program Files\Java\jdk1.8.0_221\jre\lib\security\xxx.cer (file path)" -keystore "C:\Program Files\Java\jdk1.8.0_221\jre\lib\security\cacerts" -storepass changeit```
