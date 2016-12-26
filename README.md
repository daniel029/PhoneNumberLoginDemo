# PhoneNumberLoginDemo
  
手机号码登录Demo程序采用的是json作为和服务器返回的数据格式。
为了保证登录状态，可以采用Oauth2.0认证管理方式，通过手机号码和验证码向服务器获取access_token，refresh_token，以及expires_in,
当access_token过期时，可以通过refresh_token向程序获取更新后的access_token以及expires_in。

手机号码登录Demo程序采用MVC的架构方式，使用CocoaPods方式管理第三方库，模块划分如下：
1. Controllers
	控制器模块，包含的界面如下：
	a. PhoneNumberLoginViewController: 手机号码登录页面
	b. ChooseAreaCodeViewController: 选择国家码页面
	c. EnterAuthCodeViewController: 输入验证码页面
	d. MainViewController: 登陆后的主UI界面
	
2. NetworkManager
  网络请求访问控制模块
  a. NetworkManager类是一个单例，管理所有的网络请求
  b. ClientRequest类，每个网络请求实例的封装
  c. Protocol, 网络协议类模块，分为Request和Response两部分，对每一个请求和每一个相应都有的封装协议类。
  FetchAuthCodeRequestMessage：获取验证码请求消息
  LoginRequestMessage：手机号码和验证码登录请求消息
  RefreshTokenRequestMessage：刷新访问token请求消息
  
  FetchAuthCodeResponseMessage：获取验证码请求返回消息
  LoginResponseMessage：手机号码和验证码登录请求返回消息
  RefreshTokenRequestMessage：刷新访问token请求返回消息
  
3. General
 	程序中使用的一些通用类的模块，Categories是对既有类进行扩展的类别模块
 	
4. Macro
  程序中使用到的宏模块
  
5. Vendors
 	程序中用到的一些不能使用pods管理的第三方库，目前有两个：
 	a. AFOAuth2Manager, 一个实现了Oauth2.0认证的第三方库
 	b. libPhoneNumber, 电话号码相关操作的第三方类库，例如：可以判断某个国家的手机号码是否有效
  
6. MockTest
  程序中用来管理Mock测试的模块，目前主要用来根据不同的请求生成对应的服务器返回测试数据。
  

 