# GrowthFuel - Flutter Fitness & Habit Tracking App

A comprehensive fitness and habit tracking application built with Flutter and Supabase, featuring workout logging, habit management, historical analytics, and personalized insights.

## User Review Required

> [!IMPORTANT]
> **Supabase Account Setup**: You'll need to create a Supabase project and provide the following credentials:
> - Supabase Project URL
> - Supabase Anon/Public Key
> 
> These will be configured in the app after the initial setup. The app will NOT have a built-in "login to Supabase account" feature from the app itself - instead, you'll configure your Supabase project credentials in the app's configuration file, and users will authenticate through the app using Supabase's authentication service.

> [!WARNING]
> **Database Triggers & Scheduled Tasks**: Flutter apps cannot directly create database triggers or scheduled server-side tasks. These will need to be configured in your Supabase dashboard:
> 1. Daily habit data upload trigger (at 00:01)
> 2. Daily stats calculation function
> 
> I'll provide the SQL scripts for you to run in your Supabase SQL editor.

> [!NOTE]
> **Android Focus**: This implementation will be primarily optimized for Android. iOS deployment would require additional configuration (Apple Developer account, provisioning, etc.).

## Proposed Changes

### Project Structure

#### [NEW] Flutter Project Initialization

```
lib/
├── main.dart                          # App entry point
├── config/
│   ├── theme.dart                    # App theme with color scheme
│   └── supabase_config.dart          # Supabase configuration
├── models/
│   ├── user_model.dart               # User data model
│   ├── exercise_model.dart           # Exercise data model
│   ├── exercise_set_model.dart       # Set data model
│   ├── habit_model.dart              # Habit data model
│   └── stats_model.dart              # Statistics model
├── services/
│   ├── supabase_service.dart         # Supabase service layer
│   ├── auth_service.dart             # Authentication service
│   ├── exercise_service.dart         # Exercise CRUD operations
│   ├── habit_service.dart            # Habit CRUD operations
│   └── stats_service.dart            # Statistics service
├── screens/
│   ├── splash_screen.dart            # Splash screen
│   ├── auth/
│   │   ├── login_screen.dart         # Login screen
│   │   └── signup_screen.dart        # Signup screen
│   ├── home/
│   │   └── home_screen.dart          # Home dashboard
│   ├── exercise/
│   │   ├── exercise_tab.dart         # Main exercise tab
│   │   ├── exercise_category_view.dart # Category-specific view
│   │   └── exercise_input_form.dart  # Exercise input form
│   ├── habits/
│   │   ├── habits_screen.dart        # Habits list
│   │   ├── add_habit_screen.dart     # Add habit modal
│   │   └── habit_type_widgets.dart   # Different habit type widgets
│   ├── history/
│   │   ├── history_screen.dart       # History tab
│   │   ├── daily_view.dart           # Daily history view
│   │   ├── weekly_view.dart          # Weekly history view
│   │   └── monthly_view.dart         # Monthly calendar view
│   └── profile/
│       └── profile_screen.dart       # Profile & settings
├── widgets/
│   ├── bottom_navigation.dart        # Bottom navigation bar
│   ├── score_card.dart               # Score display card
│   ├── exercise_card.dart            # Exercise item card
│   ├── habit_card.dart               # Habit item card
│   ├── stat_chart.dart               # Charts for home screen
│   └── custom_button.dart            # Reusable button widget
└── utils/
    ├── constants.dart                # Constants and exercise categories
    └── date_utils.dart               # Date formatting helpers
```

---

### Dependencies Configuration

#### [NEW] [pubspec.yaml](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/pubspec.yaml)

Add the following dependencies:
- `supabase_flutter: ^2.0.0` - Supabase client
- `flutter_svg: ^2.0.9` - SVG support for icons
- `fl_chart: ^0.66.0` - Charts for statistics
- `intl: ^0.19.0` - Date formatting
- `shared_preferences: ^2.2.2` - Local storage
- `provider: ^6.1.1` - State management

---

### Supabase Database Schema

#### Database Tables

**1. `profiles` table** (extends Supabase auth.users)
```sql
CREATE TABLE profiles (
  id UUID REFERENCES auth.users PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**2. `exercise_names` table** (Master list of exercises)
```sql
CREATE TABLE exercise_names (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('Push', 'Pull', 'Legs', 'Upper', 'Lower')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**3. `exercises` table** (User workout data)
```sql
CREATE TABLE exercises (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  exercise_name_id UUID REFERENCES exercise_names(id),
  workout_date DATE NOT NULL,
  category TEXT NOT NULL,
  sets JSONB NOT NULL, -- Array of {set_number, weight_kg, reps, previous_weight}
  completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**4. `habit_names` table** (Master list of habits)
```sql
CREATE TABLE habit_names (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  icon TEXT,
  type TEXT NOT NULL CHECK (type IN ('Durational', 'Read', 'Task', 'Count')),
  category TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**5. `habits_data` table** (Daily habit tracking)
```sql
CREATE TABLE habits_data (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  habit_name_id UUID REFERENCES habit_names(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  completed BOOLEAN DEFAULT FALSE,
  value JSONB, -- {duration_seconds: 0} | {pages: 0} | {count: 0}
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, habit_name_id, date)
);
```

**6. `daily_stats` table** (Calculated daily statistics)
```sql
CREATE TABLE daily_stats (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  workout_score INTEGER DEFAULT 0,
  habit_score INTEGER DEFAULT 0,
  calories_burned INTEGER DEFAULT 0,
  workout_count INTEGER DEFAULT 0,
  habits_completed INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, date)
);
```

#### Row Level Security (RLS) Policies

Enable RLS on all tables and create policies to ensure users can only access their own data:

```sql
-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;
ALTER TABLE habit_names ENABLE ROW LEVEL SECURITY;
ALTER TABLE habits_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_stats ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view own profile" ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

-- Exercise policies
CREATE POLICY "Users can view own exercises" ON exercises FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own exercises" ON exercises FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own exercises" ON exercises FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own exercises" ON exercises FOR DELETE USING (auth.uid() = user_id);

-- Habit policies (similar pattern for habit_names and habits_data)
CREATE POLICY "Users can view own habits" ON habit_names FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own habits" ON habit_names FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own habits" ON habit_names FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own habits" ON habit_names FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "Users can view own habit data" ON habits_data FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own habit data" ON habits_data FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own habit data" ON habits_data FOR UPDATE USING (auth.uid() = user_id);

-- Stats policies
CREATE POLICY "Users can view own stats" ON daily_stats FOR SELECT USING (auth.uid() = user_id);
```

#### Database Functions & Triggers

**Function to calculate daily stats** (run via Supabase Edge Function or cron job):
```sql
CREATE OR REPLACE FUNCTION calculate_daily_stats(p_user_id UUID, p_date DATE)
RETURNS void AS $$
DECLARE
  v_workout_count INTEGER;
  v_habits_completed INTEGER;
  v_workout_score INTEGER;
  v_habit_score INTEGER;
BEGIN
  -- Count workouts for the day
  SELECT COUNT(DISTINCT category) INTO v_workout_count
  FROM exercises
  WHERE user_id = p_user_id AND workout_date = p_date;

  -- Count completed habits
  SELECT COUNT(*) INTO v_habits_completed
  FROM habits_data
  WHERE user_id = p_user_id AND date = p_date AND completed = TRUE;

  -- Calculate scores (simple example: 20 points per workout, 10 per habit)
  v_workout_score := v_workout_count * 20;
  v_habit_score := v_habits_completed * 10;

  -- Insert or update daily stats
  INSERT INTO daily_stats (user_id, date, workout_score, habit_score, workout_count, habits_completed)
  VALUES (p_user_id, p_date, v_workout_score, v_habit_score, v_workout_count, v_habits_completed)
  ON CONFLICT (user_id, date) 
  DO UPDATE SET
    workout_score = v_workout_score,
    habit_score = v_habit_score,
    workout_count = v_workout_count,
    habits_completed = v_habits_completed;
END;
$$ LANGUAGE plpgsql;
```

**Trigger to update stats when exercise is completed**:
```sql
CREATE OR REPLACE FUNCTION trigger_update_stats()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM calculate_daily_stats(NEW.user_id, NEW.workout_date);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stats_on_exercise
AFTER INSERT OR UPDATE ON exercises
FOR EACH ROW
EXECUTE FUNCTION trigger_update_stats();
```

---

### Core Application Components

#### [NEW] [main.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/main.dart)

Initialize Supabase, configure theme, and set up app routing.

#### [NEW] [config/theme.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/config/theme.dart)

Implement the specified color scheme:
- Primary: `#D4C5A8` (Beige)
- Accent: `#E85D04` (Orange)
- Background Dark: `#121212`
- Surface Dark: `#1E1E1E`
- Text Main: `#D4C5A8`

#### [NEW] [config/supabase_config.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/config/supabase_config.dart)

Supabase configuration with environment variables for URL and API key.

---

### Authentication Flow

#### [NEW] [screens/auth/login_screen.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/auth/login_screen.dart)

Email/password login with Supabase authentication.

#### [NEW] [screens/auth/signup_screen.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/auth/signup_screen.dart)

User registration with profile creation.

#### [NEW] [services/auth_service.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/services/auth_service.dart)

Handles sign in, sign up, sign out, and session management.

---

### Home Screen

#### [NEW] [screens/home/home_screen.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/home/home_screen.dart)

Displays:
- Personalized greeting
- Workout score and habit score cards
- Weekly workout count
- Calories burned chart (using `fl_chart`)
- Quick navigation to other sections

Fetches data from `daily_stats` table for current week.

---

### Exercise Tab

#### [NEW] [screens/exercise/exercise_tab.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/exercise/exercise_tab.dart)

Tab bar with 5 categories: Push, Pull, Legs, Upper, Lower.

#### [NEW] [screens/exercise/exercise_category_view.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/exercise/exercise_category_view.dart)

Lists exercises for selected category from `exercise_names` table. Shows:
- Exercise name
- Input fields for: Set number, Previous weight, Current weight (KG), Reps
- "+ ADD SET" button
- Checkmark to confirm set completion

#### [NEW] [screens/exercise/exercise_input_form.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/exercise/exercise_input_form.dart)

Form to input exercise data with validation. "FINISH" button saves all data to Supabase.

#### [NEW] [services/exercise_service.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/services/exercise_service.dart)

CRUD operations for exercises:
- Fetch exercise names by category
- Save workout session
- Retrieve previous workout data
- Update exercise data

---

### Habits Tab

#### [NEW] [screens/habits/habits_screen.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/habits/habits_screen.dart)

Displays list of user habits with date selector and "+" button to add new habits.

#### [NEW] [screens/habits/add_habit_screen.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/habits/add_habit_screen.dart)

Modal to create new habits with:
- Habit name input
- Category dropdown
- Icon selector
- Habit type selection (Durational, Read, Task, Count)

#### [NEW] [screens/habits/habit_type_widgets.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/habits/habit_type_widgets.dart)

Custom widgets for each habit type:
- **Durational**: Timer with play/pause button, resets daily
- **Read**: Page counter with number input/dropdown
- **Task**: Simple checkbox that resets daily
- **Count**: Increment/decrement counter

#### [NEW] [services/habit_service.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/services/habit_service.dart)

CRUD operations for habits:
- Fetch user habits
- Create new habit
- Update habit data
- Mark habit as completed
- Daily reset logic

---

### History Tab

#### [NEW] [screens/history/history_screen.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/history/history_screen.dart)

Tab switcher for Daily, Weekly, Monthly views.

#### [NEW] [screens/history/daily_view.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/history/daily_view.dart)

Shows workouts and habits completed for selected date with navigation arrows.

#### [NEW] [screens/history/weekly_view.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/history/weekly_view.dart)

Weekly summary with daily breakdown of workouts and habits.

#### [NEW] [screens/history/monthly_view.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/history/monthly_view.dart)

Calendar grid showing workout/habit indicators for each day of the month.

---

### Profile Tab

#### [NEW] [screens/profile/profile_screen.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/screens/profile/profile_screen.dart)

User profile with:
- Profile information display
- Settings (Dark Mode toggle, Units preference)
- Support links (Help Center, Privacy Policy)
- Logout button

---

### Shared Components

#### [NEW] [widgets/bottom_navigation.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/widgets/bottom_navigation.dart)

Bottom navigation bar with 5 tabs matching the UI images with orange accent for active tab.

#### [NEW] [utils/constants.dart](file:///c:/Users/LENOVO/Documents/AntiGravity_Projects/GrowthFuel/lib/utils/constants.dart)

Exercise categories and names:
- Push: Bench press, Incline bench press, Lateral dumbbell raise, Cable overhead triceps extension
- Pull: Chest supported rows, Lat pulldown, Barbell curl, Pull-up, Wrist curl
- Legs: Hack squat, Lying leg curl, Standing calf raise, Seated leg curls
- Upper: Cable tricep pushdown, Dumbbell bench press, Barbell row, Seated incline dumbbell press
- Lower: Deadlift, Seated leg curl, Leg extension, Standing calf raises

---

## Verification Plan

### Automated Tests

1. **Unit Tests**:
   ```bash
   flutter test
   ```
   Test models, services, and utility functions.

2. **Widget Tests**:
   Test individual screen widgets and user interactions.

3. **Integration Tests**:
   Test complete user flows (login → exercise logging → habit tracking → history view).

### Manual Verification

1. **Supabase Setup**:
   - Create Supabase project
   - Run SQL scripts to create tables, RLS policies, and functions
   - Verify database structure in Supabase dashboard
   - Test authentication flow

2. **App Testing**:
   - Install app on Android device/emulator
   - Test user registration and login
   - Log exercises and verify data persistence
   - Add habits and track completion
   - Verify daily reset at 00:01 (test with manual date change)
   - Check history views (daily, weekly, monthly)
   - Test profile settings and logout

3. **UI Verification**:
   - Compare app screens with provided mockups
   - Verify color scheme matches specifications
   - Test responsive layouts
   - Verify navigation flows

4. **Database Verification**:
   - Check that exercise data is saved correctly on "FINISH"
   - Verify habit data uploads at end of day
   - Confirm stats are calculated correctly
   - Test data retrieval for charts and history

5. **Performance Testing**:
   - Test app performance with large datasets
   - Verify smooth scrolling and animations
   - Check network request optimization
