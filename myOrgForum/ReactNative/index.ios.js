'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TabBarIOS,
  NavigatorIOS,
} = React;

var ListView = require('./components/ListView');
var Home = require('./Home');

var RNIndexPage = React.createClass({
  getInitialState(){
    return {
      selectedTab:'home'
    }
  },
  changeTab(tabName){
    this.setState({
      selectedTab:tabName
    });
  },
  render: function() {
    return (
      <TabBarIOS>
        <TabBarIOS.Item
          title = "首页"
          icon = {require('image!icon_tabbar_homepage_selected')}
          onPress = {()=> this.changeTab('home')}
          selected = { this.state.selectedTab === 'home'}>
          <NavigatorIOS
            style={styles.container}
            
            initialRoute={{
            title: '首页',
            component: Home,
            //rightButtonIcon: require('image!icon_tabbar_onsite'),
            }}
          />
        </TabBarIOS.Item>

        <TabBarIOS.Item
          title = "论坛"
          icon = {require('image!icon_tabbar_onsite')}
          onPress = {()=> this.changeTab('shangmen')}
          selected = { this.state.selectedTab === 'shangmen'}>
          <NavigatorIOS
            style={styles.container}
            initialRoute={{
            title: '论坛',
            component: ListView,
            }}
          />
        </TabBarIOS.Item>

        <TabBarIOS.Item
          title = "发现"
          icon = {require('image!icon_tabbar_merchant_normal')}
          onPress = {()=> this.changeTab('shangjia')}
          selected = { this.state.selectedTab === 'shangjia'}>
          <NavigatorIOS
            style={styles.container}
            initialRoute={{
            title: '发现',
            component: ListView,
            }}
          />
        </TabBarIOS.Item>

        <TabBarIOS.Item
          title = "我的"
          icon = {require('image!icon_tabbar_mine')}
          onPress = {()=> this.changeTab('wode')}
          selected = { this.state.selectedTab === 'wode'}>
          <NavigatorIOS
            style={styles.container}
            initialRoute={{
            title: '我的',
            component: ListView,
            }}
          />
        </TabBarIOS.Item>
      </TabBarIOS>
    );
  }
});

var styles = StyleSheet.create({
  pageView:{
    backgroundColor: '#fff',
    flex:1
  },
  container:{
    flex:1,
    backgroundColor:'white',
  },
});

AppRegistry.registerComponent('RNIndexPage', () => RNIndexPage);
