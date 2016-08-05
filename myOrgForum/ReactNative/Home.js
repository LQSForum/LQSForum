'use strict'

var React = require('react-native');

var {
	ScrollView,
	View,
	Platform,
	StyleSheet,
} = React;

var CloverSlider = require('./components/CloverSlider');
var ListView = require('./components/ListView');
var MenuCard = require('./components/MenuCard');
var RushCell = require('./components/RushCell');
var WebView = require('./components/WebView');
var Discount = require('./components/Discount');
var DisWebView = require('./components/DisWebView');

var Home = React.createClass({
	//初始化
	getInitialState(){
		return {
			//配置项
		};
	},

	//选中一行
  	selectShop:function(shopData : Object){
  		if (Platform.OS === 'ios') {
  			this.props.navigator.push({
  				title:'限时抢购',
  				component:WebView,
  				passProps:{shopData},
  			});
  		}else{
  			//android对应的处理
  		}
  	},

  	selectRush:function(){
  		if (Platform.OS === 'ios') {
  			this.props.navigator.push({
  				title:'限时抢购',
  				component:WebView,
  				passProps:{},
  			});
  		}else{
  			//android对应的处理
  		}
  	},
  	selectDiscount:function(url){
  		console.log('dis _' + url);
  		if (Platform.OS === 'ios') {
  			this.props.navigator.push({
  				title:'限时抢购',
  				component:DisWebView,
  				passProps:{url},
  			});
  		}else{
  			//android对应的处理
  		}
  	},
	render(){
		return (
			<View style = {styles.container}>
				<ScrollView>
					<CloverSlider />
					<View style={{height : 4, backgroundColor : '#F2F2F2'}} />
					<MenuCard />
					<View style={{height : 4, backgroundColor : '#F2F2F2'}} />
					<RushCell
						onSelect = {() => this.selectRush()}
					/>
					<View style={{height : 4, backgroundColor : '#F2F2F2'}} />
					<Discount 		
						onSelect1 = {(a) => this.selectDiscount(a)}
					/>
					<View style={{height : 4, backgroundColor : '#F2F2F2'}} />
					<ListView
						onSelect = {() => this.selectShop('')}
					/>
				</ScrollView>
			</View>
		);
	},
});

var styles = StyleSheet.create({
	container:{
    flex:1,
    backgroundColor:'white',
  },
});

module.exports = Home;
