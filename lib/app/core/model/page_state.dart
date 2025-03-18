/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-03-13 15:48:20
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-13 15:50:13
 * @FilePath: /flutter-template-getx/lib/app/core/model/page_state.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
enum PageState {
  DEFAULT,      //页面的初始默认状态。
  LOADING,      //页面正在加载数据，可用于显示加载中的提示，如加载进度条。
  SUCCESS,      //数据加载成功，可用于显示正常的页面内容
  FAILED,       //数据加载失败，可用于显示错误提示。
  UPDATED,      //数据更新成功，可用于提示用户数据已更新。
  CREATED,      //数据创建成功，可用于提示用户新数据已创建
  NO_INTERNET,  //网络连接失败，可用于提示用户检查网络连接
  MESSAGE,      //用于显示一般性的消息提示。
  UNAUTHORIZED, //用户未授权，可用于引导用户进行登录或授权操作。
}
