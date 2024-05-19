
PERSONAL TASK MANAGER

This Flutter application, utilizing Firebase and Firestore for its backend, is designed to streamline task management with efficient CRUD operations. Users can easily register and log in using their email credentials. Once authenticated, they gain access to a user-friendly interface where they can add, update, delete, and view tasks. Each task comes with a scheduled alert feature that triggers an alarm 10 minutes before the task's set time, ensuring users never miss important deadlines. The app’s integration with Firebase ensures real-time data synchronization and secure user authentication. Whether managing daily chores or professional deadlines, this app provides a reliable solution for staying organized and punctual.


## App Task Page
![Task Page](https://github.com/inshadaliqbal/PersonalTaskManager/blob/main/taskpage.jpeg)
## Plugins

 - [Firebase Core](https://pub.dev/packages/firebase_core)
 - [Firebase Auth](https://pub.dev/packages/firebase_auth)
 - [Firestore Cloud](https://pub.dev/packages/cloud_firestore)
 - [Provider Package](https://pub.dev/packages/provider)
 - [Connectivity Plus](https://pub.dev/packages/connectivity_plus)
 - [Animated Text Kit](https://pub.dev/packages/animated_text_kit)
 - [Awesome Snackbar](https://pub.dev/packages/awesome_snackbar_content)
 - [Alarm](https://pub.dev/packages/alarm)
 


## App Description

Welcome to my advanced task management application, crafted with Flutter and powered by Firebase and Firestore. This app is designed to offer a seamless and efficient user experience, allowing users to manage their tasks with ease and reliability.

### Key Features

- **User Authentication**: Users can register and log in using their email credentials, thanks to Firebase Authentication. This ensures a secure and personalized experience for each user.
  
- **Real-time Connectivity Monitoring**: Utilizing the Connectivity Plus package, the app continuously monitors the network status. Each time a user navigates to a new page, the app checks for connectivity issues. If any issues are detected, a bottom snack bar notification is displayed, informing the user without causing the app to crash. This ensures a smooth and uninterrupted user experience.
  
- **Robust Error Handling**: To handle potential errors gracefully, the app employs try-catch blocks throughout its operations. If an error occurs, a snack bar alert is triggered, providing immediate feedback to the user about the issue.
  
- **State Management with Provider**: The app uses the Provider package for efficient state management. This enables real-time updates and interactions within the app, ensuring that all task-related operations are smooth and responsive.
  
- **Comprehensive CRUD Operations**: Users can create, read, update, and delete tasks effortlessly. Each task entry is designed to show the remaining time until its deadline, helping users stay on top of their schedule.
  
- **Task Alerts**: To ensure that users are reminded of their tasks, the app features an alarm that triggers 10 minutes before each task's scheduled time. This proactive reminder helps users manage their time effectively.
  
- **Interactive Task Management**: Users can check and uncheck tasks using a Cupertino button, making task management intuitive and user-friendly. Completed tasks can be marked with a simple tap, helping users keep track of their progress.
  
- **Task Deletion**: Tasks can be deleted easily by long-pressing on the task entry. This feature provides a quick and efficient way to manage and organize tasks without clutter.

### Technical Implementation

- **Firebase Integration**: The app leverages Firebase for authentication and Firestore for database operations. This integration ensures secure data storage and real-time data synchronization across all user devices.
  
- **Connectivity Plus**: Continuous network status monitoring is achieved using the Connectivity Plus package, providing real-time feedback and ensuring that the app remains operational even in varying network conditions.
  
- **Error Handling**: Implementing try-catch blocks throughout the app, combined with snack bar notifications, ensures that users are always informed of any issues without disrupting their experience.
  
- **State Management with Provider**: By using Provider for state management, the app maintains a reactive and efficient interface, allowing for real-time updates and seamless user interactions.
  
- **Task Scheduling and Alerts**: The app calculates the remaining time for each task and schedules alerts accordingly. This feature is crucial for time management, helping users stay ahead of their tasks.

### User Experience

Personal task management app is designed with the user in mind, providing a reliable, intuitive, and efficient tool for managing daily tasks. With real-time connectivity checks, robust error handling, and proactive task reminders, users can focus on their productivity without worrying about technical glitches or missed deadlines. The integration of Firebase and Firestore ensures secure and reliable data management, while the use of Provider for state management guarantees a responsive and dynamic user experience.

Whether you need to manage personal chores or professional deadlines, our app offers the tools you need to stay organized and productive.

## Screenshots

![Welcome Screen](https://github.com/inshadaliqbal/PersonalTaskManager/blob/main/welcomepage.jpeg)
![Authentication Page](https://github.com/inshadaliqbal/PersonalTaskManager/blob/main/authenticationpage.jpeg)
![Task Page](https://github.com/inshadaliqbal/PersonalTaskManager/blob/main/taskpage.jpeg)
![Add Task Page](https://github.com/inshadaliqbal/PersonalTaskManager/blob/main/addtaskpage.jpeg)
![Reminder Page](https://github.com/inshadaliqbal/PersonalTaskManager/blob/main/reminderpage.jpeg)


