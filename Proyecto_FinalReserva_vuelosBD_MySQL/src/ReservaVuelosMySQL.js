const express = require('express');
const app = express();

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient()

//Middlewares
app.use(express.json());

//rutas

//PASAJEROS
//get routes
app.get("/Pasajeros",async (req, res)=>{
    const passagers = await prisma.pasajeros.findMany()
    res.json({ passagers });
})

//post routes
app.post("/Pasajero",async (req, res)=>{
    const passanger = await prisma.pasajeros.create({
        data: req.body,
    });
    res.json({ passanger });
})

//PUT routes
app.put('/pasajero/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const updatedPassenger = await prisma.pasajeros.update({
        where: { pasajero_id: id },
        data: req.body,
      });
      res.json({ updatedPassenger });
    } catch (error) {
      res.status(500).json({ error: 'Error al actualizar el pasajero' });
    }
  });

//DELETE
app.delete('/pasajero/:id', async (req, res) => {
    try {
      const { id } = req.params;
      await prisma.pasajeros.delete({
        where: { pasajero_id: id },
      });
      res.json({ message: 'Pasajero eliminado correctamente' });
    } catch (error) {
      res.status(500).json({ error: 'Error al eliminar el pasajero' });
    }
  });


//BOLETOS
//get routes
app.get("/boletos", async (req, res)=>{
    const tickets = await prisma.boletos.findMany({
        select:{
            clase: true,
            precio: true,
            pasajeros:{
                select:{
                    nombre:true    
                }     
            },
            aerolineas:{
                select:{
                    nombre: true,
                    codigo_iata: true
                }
            }
        },
    })
    res.json({ tickets });
});

//post routes
app.post("/boleto",async (req, res)=>{
    const ticket = await prisma.boletos.create({
        data: req.body,
    });
    res.json({ ticket });
});

//PUT routes
app.put('/boleto/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const updatedTicket = await prisma.boletos.update({
        where: { boleto_id: id },
        data: req.body,
      });
      res.json({ updatedTicket });
    } catch (error) {
      res.status(500).json({ error: 'Error al actualizar el boleto' });
    }
  });

//DELETE
app.delete('/boleto/:id', async (req, res) => {
    try {
      const { id } = req.params;
      await prisma.pasajeros.delete({
        where: { pasajero_id: id },
      });
      res.json({ message: 'Boleto eliminado correctamente' });
    } catch (error) {
      res.status(500).json({ error: 'Error al eliminar el pasajero' });
    }
  });

//VUELOS
//get routes
app.get("/vuelos",async (req, res)=>{
    const flights = await prisma.vuelos.findMany({
        include:{
            ruta_destino:{
                select:{
                    km_recorido: true,
                    pais: true
                },
            },
        },
    });
    res.json({ flights });
})

//post routes
app.post("/vuelo",async (req, res)=>{
    const flight = await prisma.vuelos.create({
        data: req.body,
    });
    res.json({ vuelos });
})

//PUT routes
app.put('/vuelo/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const updatedFlight = await prisma.vuelos.update({
        where: { vuelos_id: id },
        data: req.body,
      });
      res.json({ updatedFlight });
    } catch (error) {
      res.status(500).json({ error: 'Error al actualizar el vuelo' });
    }
  });

//DELETE
app.delete('/vuelo/:id', async (req, res) => {
    try {
      const { id } = req.params;
      await prisma.vuelos.delete({
        where: { vuelos_id: id },
      });
      res.json({ message: 'Vuelo eliminado correctamente' });
    } catch (error) {
      res.status(500).json({ error: 'Error al eliminar el vuelo' });
    }
  });

//AEROLINEAS
//get routes
app.get("/aerolineas",async (req, res)=>{
    const airlines = await prisma.aerolineas.findMany();
    res.json({ airlines });
})

//post routes
app.post("/aerolinea",async (req, res)=>{
    const airline = await prisma.aerolineas.create({
        data: req.body,
    });
    res.json({ airline });
})

//PUT routes
app.put('/aerolinea/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const updatedAirline = await prisma.aerolineas.update({
        where: { id_aerolinea: id },
        data: req.body,
      });
      res.json({ updatedAirline });
    } catch (error) {
      res.status(500).json({ error: 'Error al actualizar la aerolinea' });
    }
  });

//DELETE
app.delete('/aerolinea/:id', async (req, res) => {
    try {
      const { id } = req.params;
      await prisma.aerolineas.delete({
        where: { id_aerolinea: id },
      });
      res.json({ message: 'Aerolinea eliminado correctamente' });
    } catch (error) {
      res.status(500).json({ error: 'Error al eliminar la aerolinea' });
    }
  });


//DESTINOS
//get routes
app.get("/destinos",async (req, res)=>{
    const destinations = await prisma.destinos.findMany();
    res.json({ destinations });
})

//post routes
app.post("/destino",async (req, res)=>{
    const destination = await prisma.destinos.create({
        data: req.body,
    });
    res.json({ destination });
})

//PUT routes
app.put('/destino/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const updatedDestination = await prisma.destinos.update({
        where: { destino_id: id },
        data: req.body,
      });
      res.json({ updatedDestination });
    } catch (error) {
      res.status(500).json({ error: 'Error al actualizar el destino' });
    }
  });

//DELETE
app.delete('/destino/:id', async (req, res) => {
    try {
      const { id } = req.params;
      await prisma.destinos.delete({
        where: { destino_id: id },
      });
      res.json({ message: 'Destino eliminado correctamente' });
    } catch (error) {
      res.status(500).json({ error: 'Error al eliminar el destino' });
    }
});

//ORIGEN
//get routes
app.get("/origenes",async (req, res)=>{
    const origins = await prisma.origen.findMany();
    res.json({ origins });
})

//post routes
app.post("/origen",async (req, res)=>{
    const origin = await prisma.origen.create({
        data: req.body,
    });
    res.json({ origin });
})

//PUT routes
app.put('/origen/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const updatedOrigin = await prisma.origen.update({
        where: { origen_id: id },
        data: req.body,
      });
      res.json({ updatedOrigin });
    } catch (error) {
      res.status(500).json({ error: 'Error al actualizar el origen' });
    }
  });

//DELETE
app.delete('/origen/:id', async (req, res) => {
    try {
      const { id } = req.params;
      await prisma.origen.delete({
        where: { origen_id: id },
      });
      res.json({ message: 'Origen eliminado correctamente' });
    } catch (error) {
      res.status(500).json({ error: 'Error al eliminar el origen' });
    }
});


//RUTAS DESTINO
//get routes
app.get("/rutasDestino",async (req, res)=>{
    const destinationRoutes = await prisma.ruta_destino.findMany({
        include:{
            origen:{
                select:{
                    nombre: true,
                    latitud_origen: true,
                    longitud_origen: true
                },
            },
            destinos:{
                select:{
                    nombre: true,
                    latitud_destino: true,
                    longitud_destino: true
                }
            }
        },
    });
    res.json({ destinationRoutes });
})

//post routes
app.post("/rutaDestino",async (req, res)=>{
    const destinationRoute = await prisma.ruta_destino.create({
        data: req.body,
    });
    res.json({ destinationRoute });
})

//PUT routes
app.put('/rutaDestino/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const updatedDestinationRoute = await prisma.ruta_destino.update({
        where: { r_destino_id: id },
        data: req.body,
      });
      res.json({ updatedDestinationRoute });
    } catch (error) {
      res.status(500).json({ error: 'Error al actualizar la ruta destino' });
    }
  });

//DELETE
app.delete('/rutaDestino/:id', async (req, res) => {
    try {
      const { id } = req.params;
      await prisma.ruta_destino.delete({
        where: { r_destino_id: id },
      });
      res.json({ message: 'Ruta Destino eliminado correctamente' });
    } catch (error) {
      res.status(500).json({ error: 'Error al eliminar la rutaDestino' });
    }
  });

//PASAJEROS ATRASADOS
//get routes
app.get("/pasajerosA",async (req, res)=>{
    const delayedPassengers = await prisma.pasajeros_atrasados.findMany({
        select:{
            motivo: true,
            hora_registro: true,
            boletos_boleto_id:true,
                    boletos:{        
                        select:{
                            pasajeros:{
                                select:{
                                    pasajero_id:true,
                                    nombre:true,
                                    apellido:true  
                                }
                                
                            }
                        }

                    }, 
        },
    });
    res.json({ delayedPassengers });
})

//post routes
app.post("/pasajeroA",async (req, res)=>{
    const delayedPassenger = await prisma.pasajeros_atrasados.create({
        data: req.body,
    });
    res.json({ delayedPassenger });
})

//PUT routes
app.put('/pasajeroA/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const updatedDelayedPassenger = await prisma.pasajeros_atrasados.update({
        where: { pasajero_a_id: id },
        data: req.body,
      });
      res.json({ updatedDelayedPassenger });
    } catch (error) {
      res.status(500).json({ error: 'Error al actualizar el pasajero de la tabla pasajeros atrasados' });
    }
  });

//DELETE
app.delete('/pasajeroA/:id', async (req, res) => {
    try {
      const { id } = req.params;
      await prisma.pasajeros_atrasados.delete({
        where: { pasajeros_a_id: id },
      });
      res.json({ message: 'Ruta Destino eliminado correctamente' });
    } catch (error) {
      res.status(500).json({ error: 'Error al eliminar la rutaDestino' });
    }
});

app.listen(3000, () => {
    console.log('ejecutandose...');
});