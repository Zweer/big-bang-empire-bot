import bigBangEmpire from '../libs/big-bang-empire';

class GuildModule {
  isGuildMember(id: number): boolean {
    return bigBangEmpire.game.guild_members.some((member) => member.id === id);
  }
}

export default new GuildModule();
