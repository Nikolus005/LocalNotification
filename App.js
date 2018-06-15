/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  Label,
  Button,
  View
} from 'react-native';


var notificationHelper = require('NativeModules').NotificationHelper;
// notificationHelper.setNotification()


type Props = {};
export default class App extends Component<Props> {
  render() {
    return  (
      <View style={styles.container}>
        <Button onPress={() => this.bAction()} title="Generate Notification" />
        <Button onPress={() => this.logEvent()} title="log event" />
      </View>
    );
  }
  bAction(){
    notificationHelper.setNotification();
  }
  logEvent(){
  	console.log("button tap");
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
