import {
  WebSocketGateway, WebSocketServer, SubscribeMessage,
  OnGatewayConnection, ConnectedSocket, MessageBody,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { Logger } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';

@WebSocketGateway({
  cors: { origin: '*', credentials: true },
  namespace: '/',
})
export class TicketsGateway implements OnGatewayConnection {
  @WebSocketServer() server: Server;
  private readonly logger = new Logger(TicketsGateway.name);

  constructor(
    private jwtService: JwtService,
    private config: ConfigService,
  ) {}

  // ── Connexion : auth JWT optionnelle ──────────────────────────────────────
  handleConnection(client: Socket) {
    try {
      const token = client.handshake.auth?.token?.replace('Bearer ', '');
      if (token) {
        const payload = this.jwtService.verify(token, {
          secret: this.config.get('JWT_ACCESS_SECRET'),
        });
        client.data.userId = payload.sub;
        client.data.role   = payload.role;
      }
      this.logger.debug(`Client connected: ${client.id}`);
    } catch {
      // Connexion publique (écran salle)
      client.data.userId = null;
    }
  }

  // ── Rejoindre rooms ────────────────────────────────────────────────────────
  @SubscribeMessage('join:ticket')
  handleJoinTicket(@ConnectedSocket() client: Socket, @MessageBody() data: { ticketId: string }) {
    client.join(`ticket:${data.ticketId}`);
  }

  @SubscribeMessage('leave:ticket')
  handleLeaveTicket(@ConnectedSocket() client: Socket, @MessageBody() data: { ticketId: string }) {
    client.leave(`ticket:${data.ticketId}`);
  }

  @SubscribeMessage('join:queue')
  handleJoinQueue(@ConnectedSocket() client: Socket, @MessageBody() data: { queueId: string }) {
    client.join(`queue:${data.queueId}`);
  }

  @SubscribeMessage('join:branch')
  handleJoinBranch(@ConnectedSocket() client: Socket, @MessageBody() data: { branchId: string }) {
    client.join(`branch:${data.branchId}`);
  }

  // ── Émettre événements ─────────────────────────────────────────────────────
  emitTicketCalled(ticket: any) {
    // → room ticket (client mobile)
    this.server.to(`ticket:${ticket.id}`).emit('ticket:called', {
      ticketId: ticket.id,
      code: ticket.code,
      counterId: ticket.counterId,
      counterName: ticket.counter?.name,
      message: 'C\'est votre tour !',
    });

    // → room queue (dashboard)
    this.server.to(`queue:${ticket.queueId}`).emit('ticket:called', {
      ticketId: ticket.id,
      code: ticket.code,
    });

    // → room branch (écran salle)
    this.server.to(`branch:${ticket.branchId}`).emit('ticket:display-called', {
      code: ticket.code,
      counterName: ticket.counter?.name ?? 'Guichet',
    });

    this.logger.log(`Ticket called: ${ticket.code}`);
  }

  emitQueueUpdate(queueId: string) {
    this.server.to(`queue:${queueId}`).emit('queue:updated', { queueId });
  }

  emitTicketUpdate(ticketId: string, data: any) {
    this.server.to(`ticket:${ticketId}`).emit('ticket:updated', data);
  }

  emitPositionRefresh(queueId: string, positions: Array<{ ticketId: string; position: number; eta: number }>) {
    this.server.to(`queue:${queueId}`).emit('queue:position-refresh', positions);
  }
}
