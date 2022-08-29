export interface GoalInterface {
  index: number;
  active: boolean;
  goal_type: number;
  mechanic_type: number;
  lookup_column: string;
  category: number;
  story_goal_category: number;
  required_goal: string;
  required_level: number;
  statistics: boolean;
  hidden: boolean;
  display_as_time: boolean;
  values: {
    [key: string]: {
      story_goal: boolean;
      reward_type: number;
      reward_factor: number;
      reward_identifier: string;
      reward_title: null;
      estimated_level: number;
      text: string;
    };
  };
}
