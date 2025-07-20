import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { ProfileScreenProps } from '../types/navigation';

export default function ProfileScreen({ route }: ProfileScreenProps) {
  const { userId } = route.params;

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Profile Screen</Text>
      {userId && <Text style={styles.text}>User ID: {userId}</Text>}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  text: {
    fontSize: 16,
  },
});