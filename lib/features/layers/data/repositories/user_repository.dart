import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:latlong2/latlong.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserEntity> getUser(String userId) async {
    return UserEntity(
      userId: userId,
      username: 'Dima',
      password: 'Qwerty123@',
      profilePicUrl:
          'https://media.licdn.com/dms/image/v2/D4E03AQE6_00Lbd-Itw/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1697047665155?e=1750291200&v=beta&t=_BBvq5lAMPw3-cY4lHbN1M2_Y2aBYAsVfnJriLT1auA',
      email: 'd.kuramshin@ufaz.az',
      streak: 5,
      points: 100,
      ghgIndex: 4.73,
      location: LatLng(413010, 49.945072),
      friendsIds: ['2', '3'],
    );
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    return [
      UserEntity(
        userId: '12346',
        username: 'Kamal',
        password: 'Qwerty123@@',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'kamal.ahmadov@ufaz.az',
        streak: 5,
        points: 110,
        ghgIndex: 4.70,
        location: LatLng(413000, 49.915072),
        friendsIds: ['1', '3'],
      ),
      UserEntity(
        userId: '12345',
        username: 'Dima',
        password: 'Qwerty123@',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQE6_00Lbd-Itw/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1697047665155?e=1750291200&v=beta&t=_BBvq5lAMPw3-cY4lHbN1M2_Y2aBYAsVfnJriLT1auA',
        email: 'd.kuramshin@ufaz.az',
        streak: 5,
        points: 120,
        ghgIndex: 4.73,
        location: LatLng(413010, 49.945072),
        friendsIds: ['2', '3'],
      ),
      UserEntity(
        userId: '12347',
        username: 'Aydin',
        password: 'Password123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'aydin.mammadov@ufaz.az',
        streak: 3,
        points: 119,
        ghgIndex: 4.65,
        location: LatLng(412900, 49.905072),
        friendsIds: ['1', '2'],
      ),
      UserEntity(
        userId: '12348',
        username: 'Leyla',
        password: 'LeylaPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'leyla.aliyeva@ufaz.az',
        streak: 7,
        points: 118,
        ghgIndex: 4.80,
        location: LatLng(412800, 49.895072),
        friendsIds: ['3', '4'],
      ),
      UserEntity(
        userId: '12349',
        username: 'Farid',
        password: 'FaridPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'farid.huseynov@ufaz.az',
        streak: 4,
        points: 117,
        ghgIndex: 4.90,
        location: LatLng(412700, 49.885072),
        friendsIds: ['5', '6'],
      ),
      UserEntity(
        userId: '12350',
        username: 'Nigar',
        password: 'NigarPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'nigar.guliyeva@ufaz.az',
        streak: 6,
        points: 123,
        ghgIndex: 4.75,
        location: LatLng(412600, 49.875072),
        friendsIds: ['7', '8'],
      ),
      UserEntity(
        userId: '12351',
        username: 'Rashad',
        password: 'RashadPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'rashad.mammadov@ufaz.az',
        streak: 2,
        points: 123,
        ghgIndex: 4.85,
        location: LatLng(412500, 49.865072),
        friendsIds: ['9', '10'],
      ),
      UserEntity(
        userId: '12352',
        username: 'Zeynab',
        password: 'ZeynabPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'zeynab.aliyeva@ufaz.az',
        streak: 8,
        points: 120,
        ghgIndex: 4.95,
        location: LatLng(412400, 49.855072),
        friendsIds: ['11', '12'],
      ),
      UserEntity(
        userId: '12353',
        username: 'Elvin',
        password: 'ElvinPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'elvin.huseynov@ufaz.az',
        streak: 5,
        points: 115,
        ghgIndex: 4.70,
        location: LatLng(412300, 49.845072),
        friendsIds: ['13', '14'],
      ),
      UserEntity(
        userId: '12354',
        username: 'Aysel',
        password: 'AyselPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'aysel.guliyeva@ufaz.az',
        streak: 9,
        points: 112,
        ghgIndex: 4.60,
        location: LatLng(412200, 49.835072),
        friendsIds: ['15', '16'],
      ),
      UserEntity(
        userId: '12355',
        username: 'Murad',
        password: 'MuradPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'murad.mammadov@ufaz.az',
        streak: 1,
        points: 110,
        ghgIndex: 4.50,
        location: LatLng(412100, 49.825072),
        friendsIds: ['17', '18'],
      ),
      UserEntity(
        userId: '12356',
        username: 'Sevda',
        password: 'SevdaPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'sevda.aliyeva@ufaz.az',
        streak: 10,
        points: 109,
        ghgIndex: 4.40,
        location: LatLng(412000, 49.815072),
        friendsIds: ['19', '20'],
      ),
      UserEntity(
        userId: '12357',
        username: 'Orkhan',
        password: 'OrkhanPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'orkhan.huseynov@ufaz.az',
        streak: 3,
        points: 108,
        ghgIndex: 4.30,
        location: LatLng(411900, 49.805072),
        friendsIds: ['21', '22'],
      ),
      UserEntity(
        userId: '12358',
        username: 'Gunel',
        password: 'GunelPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'gunel.guliyeva@ufaz.az',
        streak: 6,
        points: 105,
        ghgIndex: 4.20,
        location: LatLng(411800, 49.795072),
        friendsIds: ['23', '24'],
      ),
      UserEntity(
        userId: '12359',
        username: 'Tural',
        password: 'TuralPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'tural.mammadov@ufaz.az',
        streak: 4,
        points: 102,
        ghgIndex: 4.10,
        location: LatLng(411700, 49.785072),
        friendsIds: ['25', '26'],
      ),
      UserEntity(
        userId: '12360',
        username: 'Narmin',
        password: 'NarminPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'narmin.aliyeva@ufaz.az',
        streak: 7,
        points: 100,
        ghgIndex: 4.00,
        location: LatLng(411600, 49.775072),
        friendsIds: ['27', '28'],
      ),
      UserEntity(
        userId: '12361',
        username: 'Ilkin',
        password: 'IlkinPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'ilkin.huseynov@ufaz.az',
        streak: 5,
        points: 99,
        ghgIndex: 3.90,
        location: LatLng(411500, 49.765072),
        friendsIds: ['29', '30'],
      ),
      UserEntity(
        userId: '12362',
        username: 'Sabina',
        password: 'SabinaPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'sabina.guliyeva@ufaz.az',
        streak: 8,
        points: 89,
        ghgIndex: 3.80,
        location: LatLng(411400, 49.755072),
        friendsIds: ['31', '32'],
      ),
      UserEntity(
        userId: '12363',
        username: 'Ramin',
        password: 'RaminPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'ramin.mammadov@ufaz.az',
        streak: 2,
        points: 79,
        ghgIndex: 3.70,
        location: LatLng(411300, 49.745072),
        friendsIds: ['33', '34'],
      ),
      UserEntity(
        userId: '12364',
        username: 'Amina',
        password: 'AminaPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'amina.aliyeva@ufaz.az',
        streak: 9,
        points: 55,
        ghgIndex: 3.60,
        location: LatLng(411200, 49.735072),
        friendsIds: ['35', '36'],
      ),
      UserEntity(
        userId: '12365',
        username: 'Emin',
        password: 'EminPass123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'emin.huseynov@ufaz.az',
        streak: 1,
        points: 45,
        ghgIndex: 3.50,
        location: LatLng(411100, 49.725072),
        friendsIds: ['37', '38'],
      ),
    ];
  }

  @override
  Future<List<UserEntity>> getFriends(String userId) async {
    return [
      UserEntity(
        userId: userId,
        username: 'Dima',
        password: 'Qwerty123@',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQE6_00Lbd-Itw/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1697047665155?e=1750291200&v=beta&t=_BBvq5lAMPw3-cY4lHbN1M2_Y2aBYAsVfnJriLT1auA',
        email: 'd.kuramshin@ufaz.az',
        streak: 5,
        points: 100,
        ghgIndex: 4.73,
        location: LatLng(40.418456, 49.907582),
        friendsIds: ['12346', '12347', '12348'],
      ),
      UserEntity(
        userId: '12346',
        username: 'Kamal',
        password: 'Qwerty123@@',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
        email: 'kamal.ahmadov@ufaz.az',
        streak: 5,
        points: 110,
        ghgIndex: 4.70,
        location: LatLng(40.398456, 49.927582),
        friendsIds: ['12345', '12347', '12348', '12349'],
      ),
      UserEntity(
        userId: '12347',
        username: 'Pavel',
        password: 'Password123!',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/C4E03AQGrdlO8sT78ug/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1663355766652?e=1749081600&v=beta&t=wKnfP2SW9E27yg6owE7tjLAPKOx5GlAhzqMN5BOWC-w',
        email: 'p.kuznetsov@ufaz.az',
        streak: 3,
        points: 119,
        ghgIndex: 4.65,
        location: LatLng(40.458456, 49.857582),
        friendsIds: ['12345', '12346', '12348', '12349'],
      ),
      UserEntity(
        userId: '12348',
        username: 'Rena',
        password: 'RenaPassword',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQFBIu9J-kB1vg/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1719592835289?e=1749081600&v=beta&t=q0rtR0XkdszZIbllG59gYCvi9HYV65NlYVH0p0yZ990',
        email: 'rena@ufaz.az',
        streak: 7,
        points: 118,
        ghgIndex: 2.80,
        location: LatLng(40.409264, 49.867092),
        friendsIds: ['12345', '12346', '12347', '12349'],
      ),
      UserEntity(
        userId: '12349',
        username: 'Suad',
        password: 'SuadPassword',
        profilePicUrl:
            'https://media.licdn.com/dms/image/v2/D4E03AQHIxVV2KRBqWw/profile-displayphoto-shrink_200_200/B4EZSVG6waHgAg-/0/1737668408302?e=1749081600&v=beta&t=f9lC_Wl9YLTU8Wbi0H2X_nCuFJq54csVo6vDxZZ5vW8',
        email: 'suad@ufaz.az',
        streak: 4,
        points: 119,
        ghgIndex: 4.95,
        location: LatLng(40.388456, 49.821582),
        friendsIds: ['12345', '12346', '12347', '12348'],
      ),
    ];
  }
}
