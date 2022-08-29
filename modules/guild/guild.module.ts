import bigBangEmpire from '../game/game.module';

class GuildModule {
  isGuildMember(id: number): boolean {
    return bigBangEmpire.game.guild_members.some((member) => member.id === id);
  }
}

export default new GuildModule();
