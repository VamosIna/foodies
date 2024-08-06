# food_app

A new Flutter project.


# Screenshoot
#
![WhatsApp Image 2024-08-0![WhatsApp Image 2024-08-06 at 12 51 18](https://github.com/user-attachments/assets/ebae029d-546f-4e42-a1ce-3ee2a12da995)
6 at 12 52 13](https://github.com/user-attachments/assets/78c97dec-c013-4cbc-bbd8-411412fd63c8)

![WhatsApp Image 2024-08-06 at 12 51 50](https://github.com/user-attachments/assets/96cfe7cf-77ba-45bc-abff-43dd1cdb9ab0)



# Clean Architecture Structure

## lib/domain
- **entities/**: Contains the core business models of the application.
- **repositories/**: Defines the abstract repository interfaces that will be used by the use cases.
- **usecases/**: Contains the application-specific business rules or use cases.

## lib/data
- **datasources/**: Handles data fetching and persistence. This may include remote and local data sources.
- **repositories/**: Contains the implementation of the repository interfaces defined in the `domain` layer. It interacts with the data sources.

## lib/presentation
- **blocs/**: Contains the business logic components (BLoCs) that manage state and handle events.
- **pages/**: Contains the UI screens or pages of the application.
- **widgets/**: Contains reusable UI components or widgets.



