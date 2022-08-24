import { BigBangEmpire } from './libs/big-bang-empire';

async function main() {
  await BigBangEmpire.instance.init();

  console.log(BigBangEmpire.instance.baseUrl);
}

main()
  .catch((error) => console.error(error));
