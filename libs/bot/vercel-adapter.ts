import { kv } from '@vercel/kv';
import { StorageAdapter } from 'grammy';

export class VercelAdapter<T> implements StorageAdapter<T> {
  constructor(protected readonly ttl?: number) {}

  async read(key: string): Promise<T | undefined> {
    const session = await kv.get<string>(key);

    return session ? (JSON.parse(session) as unknown as T) : undefined;
  }

  async write(key: string, value: T): Promise<void> {
    await kv.set(key, JSON.stringify(value));

    if (this.ttl) {
      kv.expire(key, this.ttl);
    }
  }

  async delete(key: string): Promise<void> {
    await kv.del(key);
  }
}
