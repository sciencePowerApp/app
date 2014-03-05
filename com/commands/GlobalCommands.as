package com.commands
{
	import com.BaseMobileScreen;
	import com.GitHubLink;
	import com.Stored.Stored;
	
	import flash.display.Stage;

	public class GlobalCommands extends BaseGlobalCommands
	{
		
		public static var commands:Object;
		
	
		private var githubLink:GitHubLink;
		private var messaging:MessagingToUser;

	
		public function GlobalCommands(stage:Stage,callBackF:Function){
			super(stage,callBackF);
		}
		
		override public function _github(data:Object):void{
			messaging = new MessagingToUser(stage);
			messaging.doingStuff(true);
			
			function finishedSavingF():void{
				callBackF(RESET_APP);
			}
			
			function saveDataF(DO:Boolean):void{
				if(true){
					Stored.saveFiles(githubLink.files,finishedSavingF);
					messaging.yesNo(false);
				}
				githubLink.kill();
					
			}
			
			function resultF(result:Boolean):void{
				messaging.doingStuff(false);				
				if(githubLink.message!='')	messaging.yesNo(true, githubLink.message,saveDataF);
			}
			
			githubLink = new GitHubLink(data.toString(),resultF);
		}
		
		override public function render():void
		{
			if(messaging)messaging.render(BaseMobileScreen.stageWidth);
		}
		
		
		
		
	}
}