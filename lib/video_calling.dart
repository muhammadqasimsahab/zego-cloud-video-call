import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zegowith_asif/utils.dart';

final String localUserID=math.Random().nextInt(10000).toString();

class VideoCalling extends StatefulWidget {
  const VideoCalling({Key? key}) : super(key: key);

  @override
  State<VideoCalling> createState() => _VideoCallingState();
}

class _VideoCallingState extends State<VideoCalling> {
  final callingId=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title:const Text('Welcome'),
        centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: callingId,
            decoration: const InputDecoration(
              hintText: "Enter Call id",border: OutlineInputBorder()
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CallPage(callingId: callingId.text.toString())));
          }, child:const  Text('Join'))
        ],
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  final String callingId;
  const CallPage({Key? key,required this.callingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child:
    ZegoUIKitPrebuiltCall(
      appID: Utils.appId,
      appSign:Utils.appSignin,
      callID: callingId,
      userID: localUserID,
      userName: 'user_$localUserID',
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()..onOnlySelfInRoom=(context){
        Navigator.pop(context);
      },

    )
    );
  }
}
