export interface Response<T> {
  data: T & {
    time_correction: number;
    server_time: number;
  };
  error: string;
}
