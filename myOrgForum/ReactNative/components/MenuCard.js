'use strict'

var React = require('react-native');

var {
	Image,
	Text,
	View,
	StyleSheet,
} = React;

var cardData = [{
  img : 'icon_homepage_entertainmentCategory',
  text : '龙泉之声',
  link : 'http://3c.m.tmall.com'                      
},{
  img : 'icon_homepage_foottreatCategory',
  text : '新浪博客',
  link : 'http://3c.m.tmall.com'                      
},{
  img : 'icon_homepage_hotelCategory',
  text : '新浪微博',
  link : 'http://3c.m.tmall.com'                      
},{
  img : 'icon_homepage_KTVCategory',
  text : '网络直播',
  link : 'http://3c.m.tmall.com'                      
}
];
var cardData2 = [{
  img : 'icon_homepage_entertainmentCategory',
  text : '聚焦龙泉',
  link : 'http://3c.m.tmall.com'                      
},{
  img : 'icon_homepage_foottreatCategory',
  text : '走进师傅',
  link : 'http://3c.m.tmall.com'                      
},{
  img : 'icon_homepage_hotelCategory',
  text : '和尚答疑',
  link : 'http://3c.m.tmall.com'                      
},{
  img : 'icon_homepage_KTVCategory',
  text : '银杏树下',
  link : 'http://3c.m.tmall.com'                      
}
];

var MenuCard = React.createClass({
	//初始化
	getInitialState(){
		return {
			//配置项
		};
	},

	renderItems(data){
		return data.map(function(items,i){
			return (
				<View key={i} style = {styles.boxtd}>
					<Image source={{uri : items.img}} style={styles.cardImg} />
					<Text style = {styles.cardText}>
						{items.text}
					</Text>
				</View>
			)
		});
	},

	render(){
		return (
			<View style = {styles.container}>
				<View style = {styles.boxtr}>
					{this.renderItems(cardData)}
				</View>
				<View style = {styles.boxtr}>
					{this.renderItems(cardData)}
				</View>
			</View>
		)		
	},
});

var styles = StyleSheet.create({
	container:{
		flex:1,
		backgroundColor:'#fff',
	},
	boxtr:{
		flexDirection:'row',
		justifyContent:'center',
		paddingTop: 10,
        paddingBottom : 10,
        paddingLeft : 5,
        paddingRight: 5,        
	},
	boxtd:{
		flex:1,
		justifyContent:'center',
		alignItems:'center',
		padding:3,
	},
	cardImg:{
		width: 40,
		height: 40,		
	},
	cardText:{
		color:'#000',
		fontSize: 14,
		marginTop:10,
	},
});

module.exports = MenuCard;