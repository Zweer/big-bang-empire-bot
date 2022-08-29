import { UserVoucherInterface } from '../interfaces/userVoucher.interface';

export class UserVoucherModel {
  id: number;
  code: string;
  rewards: { [key: string]: number | { type: number; duration: number } };
  tsEnd: Date;

  constructor(userVoucher: UserVoucherInterface) {
    this.id = userVoucher.id;
    this.code = userVoucher.code;
    this.rewards = userVoucher.rewards && JSON.parse(userVoucher.rewards);
    this.tsEnd = new Date(userVoucher.ts_end * 1000);
  }
}
