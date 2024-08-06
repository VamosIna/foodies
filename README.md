# food_app

A new Flutter project.

## Screenshoot



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



