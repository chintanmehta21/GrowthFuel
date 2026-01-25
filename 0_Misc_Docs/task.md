# GrowthFuel Flutter App Development

## Project Setup
- [x] User manual installation of Flutter SDK (Complete)
- [x] Initialize Flutter project structure
- [x] Configure Supabase dependencies
- [x] Set up project structure (screens, widgets, services, models)
- [x] Configure app theme with specified color scheme

## Supabase Configuration

- [x] Set up Supabase project structure
- [x] Configure authentication (trigger for auto-profile creation)
- [x] Design database schema (Exercise-Names, Habits-Names, Exercise Data, Habits Data, Daily Stats)
- [x] Create database tables with proper relationships
- [x] Set up Row Level Security (RLS) policies
- [x] Configure database triggers for daily data uploads (stats auto-calculation)

## Authentication & Onboarding
- [x] Create login screen
- [x] Create signup screen
- [x] Implement Supabase authentication flow
    - [x] Google Sign-In (OAuth2.0) integration
- [x] Create splash screen with app branding

## Home Screen
- [x] Design home screen layout
- [x] Implement greeting message with user name
- [x] Create workout score card widget
- [x] Create habit score card widget
- [x] Implement weekly workout count display
- [x] Create calories burned graph/chart
- [ ] Connect to Supabase for real-time stats

## Exercise Tab
- [ ] Create tab bar with 5 categories (Push, Pull, Legs, Upper, Lower)
- [ ] Design exercise list UI for each category
- [ ] Create exercise input form (Sets, Previous Weight, Current Weight, Reps)
- [ ] Implement "+ ADD SET" functionality
- [ ] Implement "+ ADD EXERCISE" functionality
- [ ] Create "FINISH" button with data save logic
- [ ] Connect to Supabase Exercise Data DB
- [ ] Fetch exercises from Exercise-Names DB
- [ ] Implement data persistence on finish

## Habits Tab
- [ ] Create habits list view
- [ ] Design "Add New Habit" modal/screen
- [ ] Implement Durational habit type (with Play/Stop timer)
- [ ] Implement Read habit type (page counter with dropdown)
- [ ] Implement Task habit type (simple checkbox)
- [ ] Implement Count habit type (increment counter)
- [ ] Create habit card widgets for each type
- [ ] Connect to Supabase Habits Data DB
- [ ] Implement daily reset logic (00:01)
- [ ] Implement habit completion tracking

## History Tab
- [ ] Create tab switcher (Daily, Weekly, Monthly)
- [ ] Implement Daily view with workout/habit cards
- [ ] Implement Weekly view with summary
- [ ] Implement Monthly calendar view
- [ ] Show workout indicators on calendar
- [ ] Show habit indicators on calendar
- [ ] Fetch historical data from Supabase
- [ ] Implement date navigation (previous/next)

## Profile Tab
- [ ] Create profile screen layout
- [ ] Display user information
- [ ] Implement settings options (Dark Mode, Units of Measure)
- [ ] Create support links (Help Center, Privacy Policy)
- [ ] Implement logout functionality
- [ ] Connect to user profile in Supabase

## Bottom Navigation
- [x] Create bottom navigation bar
- [x] Implement navigation between 5 main tabs
- [x] Style navigation with accent colors

## Database Integration & API
- [ ] Create Supabase service layer
- [ ] Implement exercise CRUD operations
- [ ] Implement habit CRUD operations
- [ ] Set up daily stats API calls
- [ ] Implement data sync logic
- [ ] Create database triggers for end-of-day habit upload
- [ ] Create scheduled tasks for daily API calls

## Testing & Polish
- [ ] Test all user flows
- [ ] Test Supabase connectivity
- [ ] Verify database triggers
- [ ] Test on Android device/emulator
- [ ] Fix any UI/UX issues
- [ ] Optimize performance
- [ ] Final review and adjustments
